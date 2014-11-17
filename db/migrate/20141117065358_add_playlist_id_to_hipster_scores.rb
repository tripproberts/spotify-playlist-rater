class AddPlaylistIdToHipsterScores < ActiveRecord::Migration
  def change
    add_column :hipster_scores, :playlist_id, :integer
  end
end
