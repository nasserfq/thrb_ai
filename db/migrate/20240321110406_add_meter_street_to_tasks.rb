class AddMeterStreetToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :meter_street, :integer
  end
end
