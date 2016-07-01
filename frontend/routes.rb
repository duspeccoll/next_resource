ArchivesSpace::Application.routes.draw do

  match('/plugins/next_resource' => 'next_resource#index', :via => [:get])
  match('/plugins/next_resource/get' => 'next_resource#get', :via => [:get])
  match('/plugins/next_resource/create' => 'next_resource#create', :via => [:get])

end
