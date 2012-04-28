class AddSearchFieldToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :search, :text
  end
end
