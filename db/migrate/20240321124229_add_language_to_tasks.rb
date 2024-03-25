class AddLanguageToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :selected_language, :string
  end
end
