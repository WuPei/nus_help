class CreateMicroposts < ActiveRecord::Migration
  def change
  	#drop_table :microposts
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
