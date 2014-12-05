class AddDefaultToScore < ActiveRecord::Migration
  def change
    change_column :hipster_scores, :score, :float, :default => 0.0
  end
end
