class AddUserIdToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :user_id, :bigint, null: false
  end
end
