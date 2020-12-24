class AddOauthToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :uid, :string
    add_column :users, :credentials, :jsonb
  end
end
