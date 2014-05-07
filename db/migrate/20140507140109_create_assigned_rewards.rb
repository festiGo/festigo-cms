class CreateAssignedRewards < ActiveRecord::Migration
  def change
    create_table :assigned_rewards do |t|
      t.integer :user_id
      t.integer :reward_id

      t.timestamps
    end
  end
end
