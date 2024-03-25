class AddDistrictToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :district, :string
  end
end
