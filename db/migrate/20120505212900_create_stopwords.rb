class CreateStopwords < ActiveRecord::Migration
  def change
    create_table :stopwords do |t|
      t.string :word
      t.references :stopword_list

      t.timestamps
    end
    add_index :stopwords, :stopword_list_id
  end
end
