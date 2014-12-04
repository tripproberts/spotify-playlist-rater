class HipsterScore < ActiveRecord::Base

  belongs_to :playlist
  belongs_to :user

  scope :recent, ->(num) { order('updated_at DESC').limit(num) }
  scope :top, ->(num) { order('score DESC').limit(num) }

  def calculate_score
    RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
    @r_playlist = RSpotify::Playlist.find(playlist.owner_id, playlist.spotify_id)
    @previous_score = playlist.hipster_scores.last(2)[0]
    if @previous_score == self ||
        @r_playlist.snapshot_id != @previous_score.playlist_snapshot_id
      self.update(score: Calculator.score_playlist(@r_playlist))
    else
      self.update(score: @previous_score.score)
    end
    self.update(playlist_snapshot_id: @r_playlist.snapshot_id)
  end

end
