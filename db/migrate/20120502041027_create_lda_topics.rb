class CreateLdaTopics < ActiveRecord::Migration
  def change
    create_table :lda_topics do |t|
      t.decimal :alpha
      t.string :title
      t.integer :tokens
      t.references :mallet_run

      t.timestamps
    end
    add_index :lda_topics, :mallet_run_id
  end
end
