class AddRentdurationToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :rent_duration, :string
  end
end
