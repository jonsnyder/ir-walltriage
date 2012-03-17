class AddDatasetIdToPostsAndComments < ActiveRecord::Migration
  def change
    add_column :posts, :dataset_id, :integer
    add_index :posts, :dataset_id
    
    add_column :comments, :dataset_id, :integer
    add_index :comments, :dataset_id
  end
end
