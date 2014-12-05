class Playlist < ActiveRecord::Base

  has_many :hipster_scores

  def score
    hipster_scores.last.score
  end

  def update_attributes
    RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
    @r_playlist = RSpotify::Playlist.find(owner_id, spotify_id)
    args = {name: @r_playlist.name, owner_name: @r_playlist.owner.display_name}
    if @r_playlist.public
      args[:spotify_url] = @r_playlist.external_urls["spotify"]
    end
    self.update(args)
  end

end
