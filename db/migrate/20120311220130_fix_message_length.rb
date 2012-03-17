class FixMessageLength < ActiveRecord::Migration
  def up
    change_column :posts, :message, :string, :limit => 5000
    change_column :comments, :message, :string, :limit => 5000
  end

  def down
  end
end
