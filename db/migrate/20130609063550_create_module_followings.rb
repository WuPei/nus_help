class CreateModuleFollowings < ActiveRecord::Migration
  def change
    create_table :module_followings do |t|
      t.integer :mod_id
      t.integer :mod_follower_id

      t.timestamps
    end
  end
end
