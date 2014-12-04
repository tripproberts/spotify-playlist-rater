class RemovePlaylistNameFromPlaylist < ActiveRecord::Migration
  def change
    remove_column :playlists, :playlist_name, :string
  end
end
