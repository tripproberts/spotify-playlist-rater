Rails.application.routes.draw do
  root to: 'hipster_score_calculator#redirect'
  get "/🎧🎶", to: 'hipster_score_calculator#index', as: 'hipster_score_calculator'
  get '/spotify/sessions/', to: 'spotify_sessions#new', as: 'new_spotify_session'
  get '/auth/spotify/callback', to: 'spotify_sessions#create'
  get '/hipster_scores', to: 'hipster_scores#show'
  get '/user/playlists', to: 'users#playlists'
end
