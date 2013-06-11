class AddNusAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nus_account, :string
  end
end
