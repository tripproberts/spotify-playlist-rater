module RSpotify
  class Playlist < Base
    def tracks(offset: 0)

      if @tracks_cache
        return @tracks_cache
      end

      array = []
      total = 1

      while array.length < total

        url = "users/#{@owner.id}/playlists/#{@id}/tracks" \
          "?limit=100&offset=#{array.length}"

          json = if users_credentials && users_credentials[@owner.id]
                   User.oauth_get(@owner.id, url)
                 else
                   RSpotify.auth_get(url)
                 end

          array = json['items'].map do |i|
            Track.new i['track'] unless i['track'].nil?
          end.compact
          total = json['total']

      end

      @tracks_cache = tracks
      tracks
    end
  end
end
