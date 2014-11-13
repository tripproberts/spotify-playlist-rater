class User < ActiveRecord::Base
  serialize :spotify_hash, Hash

  def spotify_id
    spotify_hash["id"]
  end

end
