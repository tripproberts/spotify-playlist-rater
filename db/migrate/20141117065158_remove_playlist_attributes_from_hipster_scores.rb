class RemovePlaylistAttributesFromHipsterScores < ActiveRecord::Migration
  def change
    remove_column :hipster_scores, :playlist_id, :string
    remove_column :hipster_scores, :owner_id, :string
    remove_column :hipster_scores, :playlist_name, :string
    remove_column :hipster_scores, :owner_name, :string
    remove_column :hipster_scores, :spotify_url, :string
    remove_column :hipster_scores, :user_id, :integer
  end
end
