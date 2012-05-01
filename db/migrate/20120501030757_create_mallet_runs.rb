class CreateMalletRuns < ActiveRecord::Migration
  def change
    create_table :mallet_runs do |t|
      t.string :name
      t.integer :num_topics
      t.integer :num_iterations
      t.integer :optimize_burn_in
      t.boolean :use_symetric_burn_in
      t.decimal :alpha
      t.references :dataset
      t.integer :state

      t.timestamps
    end
    add_index :mallet_runs, :dataset_id
  end
end
