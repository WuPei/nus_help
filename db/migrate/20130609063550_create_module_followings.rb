class CreateModuleFollowings < ActiveRecord::Migration
	def change
    	create_table :module_followings do |t|
      	t.integer :mod_id
      	t.integer :mod_follower_id
      	t.timestamps
	end
	add_index :module_followings, :mod_id
	add_index :module_followings, :mod_follower_id
	add_index :module_followings, [:mod_id, :mod_follower_id], unique: true
  end
end
