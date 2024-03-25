class AddDiretionToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :direction, :string
  end
end
