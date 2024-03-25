class AddBathroomsToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :bathrooms, :integer
  end
end
