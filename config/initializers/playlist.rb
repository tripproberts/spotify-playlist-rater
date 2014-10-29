module RSpotify
  class Playlist < Base

    def initialize(options = {})
      @collaborative = options['collaborative']
      @description   = options['description']
      @followers     = options['followers']
      @images        = options['images']
      @name          = options['name']
      @public        = options['public']
      @snapshot_id   = options['snapshot_id']

      @owner = if options['owner']
                 User.new options['owner']
               end

      @tracks_cache = if options['tracks'] && options['tracks']['items']
                        options['tracks']['items'].map { |i| Track.new i['track'] }
                      end

      super(options)
    end

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
