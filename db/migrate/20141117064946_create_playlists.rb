class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :owner_name
      t.string :owner_id
      t.string :spotify_url
      t.integer :user_id
      t.string :spotify_id

      t.timestamps
    end
  end
end
