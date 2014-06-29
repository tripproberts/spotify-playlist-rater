class CreateSpotifySessions < ActiveRecord::Migration
  def change
    create_table :spotify_sessions do |t|
      t.string :refresh_token
    end
  end
end
