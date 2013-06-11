class AddIndexToUsersAccount < ActiveRecord::Migration
  def change
  	add_index  :users, :account
  end
end
