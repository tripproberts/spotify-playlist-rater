class CreateHipsterScores < ActiveRecord::Migration
  def change
    create_table :hipster_scores do |t|
      t.float :score
      t.string :playlist_id
      t.string :owner_id

      t.timestamps
    end
  end
end
