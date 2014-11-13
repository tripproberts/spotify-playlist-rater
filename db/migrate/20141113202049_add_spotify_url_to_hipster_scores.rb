class AddSpotifyUrlToHipsterScores < ActiveRecord::Migration
  def change
    add_column :hipster_scores, :spotify_url, :string
  end
end
