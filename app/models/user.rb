class User < ActiveRecord::Base
  serialize :spotify_hash, Hash
end
