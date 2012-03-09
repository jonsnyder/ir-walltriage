class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :page
      t.string :facebook_id
      t.string :from_name
      t.string :from_id
      t.string :message
      t.string :type
      t.timestamp :created_time
      t.string :photo_url
      t.string :link_url
      t.string :link_name
      t.string :link_caption
      t.string :link_desc
      t.string :video_url
      t.integer :like_count
      t.integer :comment_count
      t.integer :share_count

      t.timestamps
    end
    add_index :posts, :page_id
  end
end
