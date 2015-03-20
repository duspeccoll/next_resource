class NextResourceController < ApplicationController

	set_access_control "view_repository" => [:index, :resolve]

	def index
	end

	def resolve
		@colls = JSONModel::HTTP::get_json("/repositories/#{session[:repo_id]}/resources", :all_ids => true)
		@colls_in_range = []
		@colls.each do |coll|
			@resource = JSONModel::HTTP::get_json("/repositories/#{session[:repo_id]}/resources/#{coll}")['id_0']
			if @resource.match(/^#{params[:range]}/)
				if @resource != "U901"
					@colls_in_range << @resource
				end
			end
		end
	
		render :json => @colls_in_range
	end

end
