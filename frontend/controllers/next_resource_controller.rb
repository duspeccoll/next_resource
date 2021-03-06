class NextResourceController < ApplicationController

	set_access_control "view_repository" => [:index, :new],
	                   "update_resource_record" => [:create]

	def index
	end

	def new
		@id = fetch_id(params[:area])
	end

	def create
		response = post_resource(params)

		if response.code == '200'
			id = ASUtils.json_parse(response.body)['id']
			flash[:success] = I18n.t("plugins.next_resource.messages.success", :title => params[:title])
			redirect_to :controller => :resources, :action => :show, :id => id
		else
			error = ASUtils.json_parse(response.body)['error']
			flash[:error] = "An error occurred: #{error}"
			redirect_to request.referer
		end
	end

	private

	def fetch_id(area)
		response = JSONModel::HTTP::post_form("/repositories/#{session[:repo_id]}/next_resource", {:area => area})
		json = ASUtils.json_parse(response.body)
		if json['id']
			return json['id']
		else
			flash[:error] = "#{json['error']}"
			redirect_to request.referer
		end
	end

	def post_resource(params)
    lang_materials = []
		dates = []
		extents = []

    # language of materials defaults to "Undefined"
    # (can be updated after initial post by a processing archivist)
    lang_materials.push(JSONModel(:lang_material).new({
      :language_and_script => JSONModel(:language_and_script).new({:language => "und"})
    }))

		dates.push(JSONModel(:date).new({
			:expression => "Date Not Yet Determined",
			:date_type => "single",
			:label => "other"
		}))

		extents.push(JSONModel(:extent).new({
			:portion => "whole",
			:number => "0",
			:extent_type => "linear_feet"
		}))

    # language of description defaults to lang = "English," script = "Latin"
		record = JSONModel(:resource).new({
			:title => params[:title],
			:publish => false,
			:id_0 => params[:id],
			:level => "collection",
      :finding_aid_description_rules => "dacs",
      :finding_aid_language => "eng",
      :finding_aid_script => "Latn",
      :lang_materials => lang_materials,
			:dates => dates,
			:extents => extents
		}).to_json

		url = URI("#{JSONModel::HTTP.backend_url}/repositories/#{session[:repo_id]}/resources")
		resp = JSONModel::HTTP::post_json(url, record)

		resp
	end

end
