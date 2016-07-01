class NextResourceController < ApplicationController

	set_access_control "view_repository" => [:index, :get],
	                   "update_resource_record" => [:create, :build]

	def index
	end

	def get
		render :json => JSONModel::HTTP::get_json("/repositories/#{session[:repo_id]}/next_resource", 'area' => params[:area])
	end

	def create
		resource = build(params[:id])
		url = URI("#{JSONModel::HTTP.backend_url}/repositories/#{session[:repo_id]}/resources")
		response = JSONModel::HTTP::post_json(url, resource)
		if response.code === "200"
			res_id = ASUtils.json_parse(response.body)['id']
			flash[:success] = I18n.t("plugins.next_resource.messages.success", :id => params[:id])
			redirect_to :controller => :resources, :action => :show, :id => res_id
		else
			errors = ASUtils.json_parse(response.body)['error']
			flash[:error] = I18n.t("plugins.next_resource.messages.error", :id => params[:id])
			redirect_to request.referer
		end
	end

	private

	def build(id)
		title = case
		when id.start_with?("B")
			"New Beck Archives collection"
		when id.start_with?("D")
			"New Carson Brierly Giffin Dance Library collection"
		when id.start_with?("U")
			"New University Archives collection"
		when id.start_with?("M")
			"New Special Collections manuscript collection"
		end

		dates = Array.new()
		extents = Array.new()

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

		record = JSONModel(:resource).new({
			:title => title,
			:publish => false,
			:id_0 => id,
			:level => "collection",
			:dates => dates,
			:extents => extents
		}).to_json

		record
	end

end
