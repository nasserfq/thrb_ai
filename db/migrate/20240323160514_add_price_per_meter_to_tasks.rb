class AddPricePerMeterToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :price_per_meter, :decimal
  end
end
