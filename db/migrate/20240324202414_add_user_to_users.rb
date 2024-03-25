class AddUserToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user, :string
  end
end
