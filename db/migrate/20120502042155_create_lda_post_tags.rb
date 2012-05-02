class CreateLdaPostTags < ActiveRecord::Migration
  def change
    create_table :lda_post_tags do |t|
      t.references :post
      t.references :lda_topic
      t.references :strategy

      t.timestamps
    end
    add_index :lda_post_tags, :post_id
    add_index :lda_post_tags, :lda_topic_id
    add_index :lda_post_tags, :strategy_id
  end
end
