class FixStringLengths < ActiveRecord::Migration
  def change
    change_column :posts, :from_name, :text
    change_column :posts, :message, :text
    change_column :posts, :photo_url, :text
    change_column :posts, :link_url, :text
    change_column :posts, :link_name, :text
    change_column :posts, :link_caption, :text
    change_column :posts, :link_desc, :text
    change_column :posts, :video_url, :text
    change_column :comments, :from_name, :text
    change_column :comments, :message, :text
  end
end
