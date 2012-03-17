class FixCommentForeignKey < ActiveRecord::Migration
  def up
    rename_column :comments, :post_id_id, :post_id
  end

  def down
  end
end
