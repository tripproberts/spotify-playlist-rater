class SpotifySessionsController < ApplicationController

  def new
  end

  def create
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @user = User.create!(spotify_hash: @spotify_user.to_hash)
    cookies.permanent.signed[:hipster] = @user.id
    redirect_to root_path
  end

end
