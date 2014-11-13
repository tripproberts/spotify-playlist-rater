class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def ensure_spotify_authorized
    unless cookies[:hipster]
      redirect_to new_spotify_session_path
    end
  end

  def current_user
    User.find(cookies.signed[:hipster])
  end

  def current_spotify_user
    user = User.find(cookies.signed[:hipster])
    RSpotify::User.new(user.spotify_hash)
  end

end
