class AddStatsFlagToAccessToken < ActiveRecord::Migration
  def change
    add_column :access_tokens, :use_for_stats, :boolean
  end
end
