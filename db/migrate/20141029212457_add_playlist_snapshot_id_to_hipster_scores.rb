class AddPlaylistSnapshotIdToHipsterScores < ActiveRecord::Migration
  def change
    add_column :hipster_scores, :playlist_snapshot_id, :string
  end
end
