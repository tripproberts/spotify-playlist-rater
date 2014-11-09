class HipsterScoresController < ApplicationController
  before_filter :ensure_spotify_authorized

  def create
    @hipster_score = HipsterScore.where(hipster_score_params).first_or_create
    render(
      json: Jbuilder.encode do |j|
        j.score @hipster_score.refresh_score
        j.playlist_id @hipster_score.playlist_id
        j.owner_id @hipster_score.owner_id
      end,
      status: 200
    )
  end

  private

  def hipster_score_params
    params.permit(:owner_id, :playlist_id)
  end

end
