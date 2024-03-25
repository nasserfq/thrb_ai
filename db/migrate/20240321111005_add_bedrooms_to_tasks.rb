class AddBedroomsToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :bedrooms, :integer
  end
end
