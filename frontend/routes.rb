ArchivesSpace::Application.routes.draw do

  match('/plugins/next_resource' => 'next_resource#index', :via => [:get])
  match('/plugins/next_resource/resolve' => 'next_resource#resolve', :via => [:get])

end
