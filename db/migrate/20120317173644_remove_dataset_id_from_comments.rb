class RemoveDatasetIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :dataset_id
  end
end
