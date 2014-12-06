class RemovePlaylistAttributesFromHipsterScores < ActiveRecord::Migration
  def change
    remove_column :hipster_scores, :playlist_id, :integer
    remove_column :hipster_scores, :owner_id, :string
    remove_column :hipster_scores, :playlist_name, :string
    remove_column :hipster_scores, :owner_name, :string
    remove_column :hipster_scores, :spotify_url, :string
  end
end
