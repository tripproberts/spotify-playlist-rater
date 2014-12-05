class PlaylistsController < ApplicationController

  def show
    @playlist = Playlist.find_by(spotify_id: params[:spotify_id])
  end

end
