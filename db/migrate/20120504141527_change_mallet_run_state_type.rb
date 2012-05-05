class ChangeMalletRunStateType < ActiveRecord::Migration
  def change
    change_column :mallet_runs, :state, :string
  end

end
