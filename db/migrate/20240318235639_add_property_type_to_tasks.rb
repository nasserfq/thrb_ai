class AddPropertyTypeToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :property_type, :string
  end
end
