class ChangeTokenFormatInUsersTable < ActiveRecord::Migration
  	def change
	change_column :users, :remember_token, :text
	end
end
