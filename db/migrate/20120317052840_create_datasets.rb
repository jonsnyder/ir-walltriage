class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.string :name
      t.string :description
      t.boolean :is_user_dataset

      t.timestamps
    end
  end
end
