class AddValidationScoreToMalletRun < ActiveRecord::Migration
  def change
    add_column :mallet_runs, :validation_score, :float
  end
end
