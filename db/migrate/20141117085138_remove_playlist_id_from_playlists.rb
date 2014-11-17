class RemovePlaylistIdFromPlaylists < ActiveRecord::Migration
  def change
    remove_column :playlists, :playlist_id, :string
  end
end
