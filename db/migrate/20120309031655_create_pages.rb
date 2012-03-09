class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :facebook_id
      t.string :name
      t.string :photo_url
      t.string :username
      t.boolean :can_post
      t.integer :like_count

      t.timestamps
    end
  end
end
