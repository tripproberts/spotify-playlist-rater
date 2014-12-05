Rails.application.routes.draw do
  root to: 'application#redirect'
  get "/🎧🎶", to: 'scores#new', as: 'new_score'
  get '/spotify/sessions/', to: 'spotify_sessions#new', as: 'new_spotify_session'
  get '/auth/spotify/callback', to: 'spotify_sessions#create'
  post '/scores', to: 'scores#create'
  get '/scores/:id', to: 'scores#show'
  get '/user/playlists', to: 'users#playlists'
  get '/playlists/:spotify_id', to: 'playlists#show', as: 'playlist'
end
