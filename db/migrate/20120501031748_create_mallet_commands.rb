class CreateMalletCommands < ActiveRecord::Migration
  def change
    create_table :mallet_commands do |t|
      t.references :mallet_run
      t.text :command
      t.text :stdout
      t.text :stderr
      t.integer :exit_status
      t.string :state

      t.timestamps
    end
    add_index :mallet_commands, :mallet_run_id
  end
end
