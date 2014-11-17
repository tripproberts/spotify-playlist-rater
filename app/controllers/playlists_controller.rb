class PlaylistsController < ApplicationController
  before_filter :ensure_spotify_authorized

  def show
    @playlist = Playlist.where(playlist_params).first_or_create
    @playlist.update_attributes
    @score = @playlist.score
    render(
      json: Jbuilder.encode do |j|
        j.score @score
        j.id @playlist.spotify_id
        j.owner_id @playlist.owner_id
      end,
      status: 200
    )
    Pusher.url = "http://550381c30d6f8b253513:22939f4cb9b7a0b88da0@api.pusherapp.com/apps/95884"
    Pusher['hipster_scores'].trigger('new_score', {
      spotify_url: @playlist.spotify_url,
      playlist_name: @playlist.name,
      owner_name: @playlist.owner_name,
      score: @score
    })
  end

  private

  def playlist_params
    params[:user_id] = current_user.id
    params[:spotify_id] = params[:id]
    params.delete(:id)
    params.permit(:spotify_id, :owner_id, :user_id)
  end

end
