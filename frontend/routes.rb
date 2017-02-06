ArchivesSpace::Application.routes.draw do

  match('/plugins/next_resource' => 'next_resource#index', :via => [:get])
  match('/plugins/next_resource/new' => 'next_resource#new', :via => [:post])
  match('/plugins/next_resource/create' => 'next_resource#create', :via => [:get])

end
