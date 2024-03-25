class AddCountryToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :country, :string
  end
end
