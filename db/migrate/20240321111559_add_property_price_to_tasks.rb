class AddPropertyPriceToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :property_price, :decimal
  end
end
