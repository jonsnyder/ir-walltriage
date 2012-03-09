class AddFbidToAccessToken < ActiveRecord::Migration
  def change
    add_column :access_tokens, :fbid, :string    
  end
end
