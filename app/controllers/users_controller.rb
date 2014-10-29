class UsersController < ApplicationController

  def playlists
    RSpotify.authenticate(ENV["SPOTIFY_ID"], ENV["SPOTIFY_SECRET"])
    @spotify_user = current_spotify_user
    @playlists = []
    @spotify_user.playlists.each do |playlist|
      playlist = {
        id: playlist.id,
        name: playlist.name,
        owner_id: playlist.owner.id
      }
      @playlists << playlist
    end
    render(
      json: Jbuilder.encode do |j|
        j.playlists @playlists
        j.total @playlists.count
      end,
      status: 200
    )
  end

end
