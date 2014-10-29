class AddPlaylistNameAndOwnerNameToHipsterScores < ActiveRecord::Migration
  def change
    add_column :hipster_scores, :playlist_name, :string
    add_column :hipster_scores, :owner_name, :string
  end
end
