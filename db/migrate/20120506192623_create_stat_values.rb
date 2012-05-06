class CreateStatValues < ActiveRecord::Migration
  def change
    create_table :stat_values do |t|
      t.references :stat
      t.references :strategy
      t.references :access_token
      t.float :value

      t.timestamps
    end
    add_index :stat_values, :stat_id
    add_index :stat_values, :strategy_id
    add_index :stat_values, :access_token_id
  end
end
