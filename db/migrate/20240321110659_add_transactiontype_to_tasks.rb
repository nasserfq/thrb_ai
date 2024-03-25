class AddTransactiontypeToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :transaction_type, :string
  end
end
