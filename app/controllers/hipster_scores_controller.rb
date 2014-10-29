class HipsterScoresController < ApplicationController
  before_filter :ensure_spotify_authorized

  def show
    @hipster_score = HipsterScore.where(hipster_score_params).first_or_create
    render(
      json: Jbuilder.encode do |j|
          j.hipster_score @hipster_score
      end,
      status: 200
    )
  end

  private

  def hipster_score_params
    params.permit(:owner_id, :playlist_id)
  end

end
