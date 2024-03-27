class AddTargetToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :target, :string
  end
end
