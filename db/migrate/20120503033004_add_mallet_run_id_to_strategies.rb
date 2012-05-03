class AddMalletRunIdToStrategies < ActiveRecord::Migration
  def change
    add_column :strategies, :mallet_run_id, :integer
    add_index :strategies, :mallet_run_id
  end
end
