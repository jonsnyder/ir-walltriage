class AddIsGoldStandardToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :is_gold_standard, :boolean

    add_index :posts, :facebook_id
  end
end
