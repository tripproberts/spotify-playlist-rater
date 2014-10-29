class DropSpotifySessions < ActiveRecord::Migration
  def change
    drop_table :spotify_sessions
  end
end
