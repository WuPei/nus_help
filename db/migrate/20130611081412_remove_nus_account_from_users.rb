class RemoveNusAccountFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :nus_account, :string
  end
end
