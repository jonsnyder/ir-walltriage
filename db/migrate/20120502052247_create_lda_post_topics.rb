class CreateLdaPostTopics < ActiveRecord::Migration
  def change
    create_table :lda_post_topics do |t|
      t.references :post
      t.references :lda_topic
      t.decimal :weight

      t.timestamps
    end
    add_index :lda_post_topics, :post_id
    add_index :lda_post_topics, :lda_topic_id
  end
end
