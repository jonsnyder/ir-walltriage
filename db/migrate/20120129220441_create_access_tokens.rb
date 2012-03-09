class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.string :name
      t.string :access_token

      t.timestamps
    end
  end
end
