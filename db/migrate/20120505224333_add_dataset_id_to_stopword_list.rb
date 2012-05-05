class AddDatasetIdToStopwordList < ActiveRecord::Migration
  def change
    add_column :stopword_lists, :dataset_id, :integer
  end
end
