class AddUserIdToHipsterScores < ActiveRecord::Migration
  def change
    add_column :hipster_scores, :user_id, :integer
  end
end
