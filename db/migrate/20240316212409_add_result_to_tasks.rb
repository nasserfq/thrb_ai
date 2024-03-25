class AddResultToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :result, :string
  end
end
