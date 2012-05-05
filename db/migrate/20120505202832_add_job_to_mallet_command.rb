class AddJobToMalletCommand < ActiveRecord::Migration
  def change
    add_column :mallet_commands, :job, :string
  end
end
