ArchivesSpace::Application.routes.draw do

  match('/plugins/next_resource' => 'next_resource#index', :via => [:get])
  match('/plugins/next_resource/generate' => 'next_resource#generate', :via => [:get])

end
