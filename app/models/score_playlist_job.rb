class ScorePlaylistJob < Struct.new(:hipster_score_id)
  def perform
    @hipster_score = HipsterScore.find(hipster_score_id)
    @playlist = @hipster_score.playlist
    @hipster_score.calculate_score
    Pusher.url = "http://550381c30d6f8b253513:22939f4cb9b7a0b88da0@api.pusherapp.com/apps/95884"
    Pusher['hipster_scores'].trigger('new_score', {
      spotify_url: @playlist.spotify_url,
      playlist_name: @playlist.name,
      owner_name: @playlist.owner_name,
      score: @hipster_score.score
    })
  end
end
