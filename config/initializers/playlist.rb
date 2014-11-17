module RSpotify
  class Playlist < Base
    def initialize(options = {})
      @collaborative = options['collaborative']
      @description   = options['description']
      @followers     = options['followers']
      @images        = options['images']
      @name          = options['name']
      @public        = options['public']
      @external_urls = options['external_urls']
      @snapshot_id   = options['snapshot_id']
      @images        = options['images']

      @owner = if options['owner']
                 User.new options['owner']
               end

      @tracks_cache = if options['tracks'] && options['tracks']['items']
                        options['tracks']['items'].map { |i| Track.new i['track'] }
                      end

      super(options)
    end
  end
end
