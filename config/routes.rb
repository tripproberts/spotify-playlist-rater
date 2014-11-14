Rails.application.routes.draw do
  root to: 'calculator#redirect'
  get "/🎧🎶", to: 'calculator#index', as: 'calculator'
  get '/spotify/sessions/', to: 'spotify_sessions#new', as: 'new_spotify_session'
  get '/auth/spotify/callback', to: 'spotify_sessions#create'
  post '/hipster_scores', to: 'hipster_scores#create'
  get '/user/playlists', to: 'users#playlists'
end
