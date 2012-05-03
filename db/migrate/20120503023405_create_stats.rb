class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.string :name
      t.string :description
      t.text :options
      t.string :type

      t.timestamps
    end
  end
end
