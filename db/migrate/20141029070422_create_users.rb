class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :spotify_hash

      t.timestamps
    end
  end
end
