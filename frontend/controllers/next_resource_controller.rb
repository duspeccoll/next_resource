class NextResourceController < ApplicationController

	set_access_control "view_repository" => [:index, :resolve]

	def index
	end

	def resolve
		@range = JSONModel::HTTP::get_json("/repositories/#{session[:repo_id]}/next_resource", 'range' => params[:range])

		if response.code == '200'
			render :json => @range
		else
			render :status => 500
		end
	end

end
