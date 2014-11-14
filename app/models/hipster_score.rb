class HipsterScore < ActiveRecord::Base

  belongs_to :user

  scope :recent, ->(num) { order('updated_at DESC').limit(num) }

  before_save :calculate_hipster_score_and_get_snapshot_id

  def refresh_score
    @playlist = RSpotify::Playlist.find(self.owner_id, self.playlist_id)
    if @playlist.snapshot_id != self.playlist_snapshot_id
      calculate_score
    end
    read_attribute(:score)
  end

  def calculate_score
    RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
    @playlist = RSpotify::Playlist.find(self.owner_id, self.playlist_id)
    args = {
      score: Calculator.score_playlist(@playlist),
      playlist_name: @playlist.name,
      owner_name: @playlist.owner.display_name,
      playlist_snapshot_id: @playlist.snapshot_id
    }
    if @playlist.public || self.owner_id != self.user.spotify_id
      args[:spotify_url] = @playlist.external_urls["spotify"]
    end
    self.update(args)
  end

  private

  def calculate_hipster_score_and_get_snapshot_id
    calculate_score if self.score.nil?
  end

end
