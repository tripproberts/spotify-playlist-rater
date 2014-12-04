class RemoveUserIdFromPlaylist < ActiveRecord::Migration
  def change
    remove_column :playlists, :user_id, :integer
  end
end
