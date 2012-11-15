class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.string :raw
      t.string :tokenized
      t.references :post
      t.references :comment
      t.references :stopword_list

      t.timestamps
    end
    add_index :sentences, :post_id
    add_index :sentences, :comment_id
    add_index :sentences, :stopword_list_id
  end
end
