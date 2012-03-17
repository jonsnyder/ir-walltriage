class CreateUserPostTags < ActiveRecord::Migration
  def change
    create_table :user_post_tags do |t|
      t.references :post
      t.references :access_token
      t.string :tag

      t.timestamps
    end
    add_index :user_post_tags, :post_id
    add_index :user_post_tags, :access_token_id
  end
end
