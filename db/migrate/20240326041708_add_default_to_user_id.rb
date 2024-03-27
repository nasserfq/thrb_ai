class AddDefaultToUserId < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tasks, :user_id, 0
  end
end
