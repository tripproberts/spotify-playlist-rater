class HipsterScore < ActiveRecord::Base

  before_save :calculate_hipster_score

  def calculate_hipster_score
    if self.score.nil?
      RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
      @playlist = RSpotify::Playlist.find(self.owner_id, self.playlist_id)
      self.score = HipsterScoreCalculator.score_playlist(@playlist)
    end
  end

end
