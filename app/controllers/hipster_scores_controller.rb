class HipsterScoresController < ApplicationController
  before_filter :ensure_spotify_authorized

  def create
    RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
    @playlist = RSpotify::Playlist.find(params[:owner_id], params[:playlist_id])
    @score = HipsterScoreCalculator.score_playlist(@playlist)
    render(
      json: Jbuilder.encode do |j|
          j.score @score
      end,
      status: 200
    )
  end

end
