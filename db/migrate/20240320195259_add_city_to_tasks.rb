class AddCityToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :city, :string
  end
end
