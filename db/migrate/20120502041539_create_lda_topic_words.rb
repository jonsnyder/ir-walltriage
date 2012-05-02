class CreateLdaTopicWords < ActiveRecord::Migration
  def change
    create_table :lda_topic_words do |t|
      t.references :lda_topic
      t.decimal :weight
      t.integer :tokens
      t.string :word

      t.timestamps
    end
    add_index :lda_topic_words, :lda_topic_id
  end
end
