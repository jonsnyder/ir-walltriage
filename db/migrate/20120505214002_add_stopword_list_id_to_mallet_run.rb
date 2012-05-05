class AddStopwordListIdToMalletRun < ActiveRecord::Migration
  def change
    add_column :mallet_runs, :stopword_list_id, :integer
  end
end
