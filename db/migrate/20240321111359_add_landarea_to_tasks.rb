class AddLandareaToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :land_area, :integer
  end
end
