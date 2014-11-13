class HipsterScoresController < ApplicationController
  before_filter :ensure_spotify_authorized

  def create
    params[:user_id] = current_user.id
    @hipster_score = HipsterScore.where(hipster_score_params).first_or_create
    render(
      json: Jbuilder.encode do |j|
        j.score @hipster_score.refresh_score
        j.playlist_id @hipster_score.playlist_id
        j.owner_id @hipster_score.owner_id
      end,
      status: 200
    )
    Pusher.url = "http://550381c30d6f8b253513:22939f4cb9b7a0b88da0@api.pusherapp.com/apps/95884"
    Pusher['hipster_scores'].trigger('new_score', {
      spotify_url: @hipster_score.spotify_url,
      playlist_name: @hipster_score.playlist_name,
      owner_name: @hipster_score.owner_name,
      score: @hipster_score.score
    })
  end

  private

  def hipster_score_params
    params.permit(:owner_id, :playlist_id, :user_id)
  end

end
