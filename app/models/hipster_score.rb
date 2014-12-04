class HipsterScore < ActiveRecord::Base

  belongs_to :playlist

  scope :recent, ->(num) { order('updated_at DESC').limit(num) }
  scope :top, ->(num) { order('score DESC').limit(num) }

  def calculate_score
    RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
    @r_playlist = RSpotify::Playlist.find(playlist.owner_id, playlist.spotify_id)
    self.update(score: Calculator.score_playlist(@r_playlist))
  end

end
