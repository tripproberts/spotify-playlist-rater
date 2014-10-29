module RSpotify
  class User < Base
    def playlists(offset: 0)
      array = []
      total = 1
      while(total > array.length)
        url = "users/#{@id}/playlists?limit=50&offset=#{array.length}"
        json = if @credentials.nil?
                 RSpotify.auth_get(url)
               else
                 User.oauth_get(@id, url)
               end
        total = json["total"]
        array.concat json['items']
      end
      array.map { |i| Playlist.new i }
    end
  end
end
