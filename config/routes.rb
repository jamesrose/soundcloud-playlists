SoundCloudApp::Application.routes.draw do

  resources :tracks
  resources :playlists
  resources :sessions, only: :new

  root :to => 'landing#index'
end
