class NextResourceController < ApplicationController

	set_access_control "view_repository" => [:index, :generate]

	def index
	end

	def generate 
		resource_id = JSONModel::HTTP::get_json("/repositories/#{session[:repo_id]}/next_resource", 'range' => params[:range])['next']

		return redirect_to(:controller => :resources, :action => :new, :resource_id => resource_id)
	
	end

end
