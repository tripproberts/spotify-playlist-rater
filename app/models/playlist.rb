class Playlist < ActiveRecord::Base

  belongs_to :user
  has_many :hipster_scores

  def score
    RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
    @r_playlist = RSpotify::Playlist.find(owner_id, spotify_id)
    @hipster_score = hipster_scores.order("created_at").last
    if @hipster_score.blank? ||
        @r_playlist.snapshot_id != @hipster_score.playlist_snapshot_id
      HipsterScore.create(
        playlist: self,
        playlist_snapshot_id: @r_playlist.snapshot_id
      ).calculate_score
    end
    @hipster_score = hipster_scores.order("created_at").last
    @hipster_score.score
  end

  def update_attributes
    RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
    @r_playlist = RSpotify::Playlist.find(owner_id, spotify_id)
    puts @r_playlist.images
    args = {name: @r_playlist.name, owner_name: @r_playlist.owner.display_name}
    if @r_playlist.public || self.owner_id != self.user.spotify_id
      args[:spotify_url] = @r_playlist.external_urls["spotify"]
    end
    self.update(args)
  end

end
