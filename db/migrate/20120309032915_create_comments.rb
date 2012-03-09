class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post_id
      t.string :facebook_id
      t.string :from_name
      t.string :from_id
      t.string :message
      t.timestamp :created_time
      t.integer :like_count

      t.timestamps
    end
    add_index :comments, :post_id_id
  end
end
