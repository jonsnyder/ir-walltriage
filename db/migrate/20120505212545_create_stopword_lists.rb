class CreateStopwordLists < ActiveRecord::Migration
  def change
    create_table :stopword_lists do |t|
      t.string :name

      t.timestamps
    end
  end
end
