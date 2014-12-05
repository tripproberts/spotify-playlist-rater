class ScoresController < ApplicationController
  before_filter :ensure_spotify_authorized

  def create
    @playlist = Playlist.where(playlist_params).first_or_create
    @playlist.update_attributes
    score_params = hipster_score_params.merge(playlist: @playlist)
    @hipster_score = HipsterScore.create(score_params)
    Delayed::Job.enqueue(ScorePlaylistJob.new(@hipster_score.id))
    render(
      json: Jbuilder.encode do |j|
        j.id @hipster_score.id
      end,
      status: 200
    )
  end

  def show
    @hipster_score = HipsterScore.find(params[:id])
    @playlist = @hipster_score.playlist
    render(
      json: Jbuilder.encode do |j|
        j.id @playlist.spotify_id
        j.name @playlist.name
        j.score @hipster_score.score
        j.owner_id @playlist.owner_id
      end,
      status: 200
    )
  end

  private

  def playlist_params
    params[:spotify_id] = params[:id]
    params.delete(:id)
    params.permit(:spotify_id, :owner_id)
  end

  def hipster_score_params
    params[:user_id] = current_user.id
    params.permit(:user_id)
  end

end
