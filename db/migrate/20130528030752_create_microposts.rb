class CreateMicroposts < ActiveRecord::Migration
	def change
		create_table :microposts do |t|
			t.string :title
			t.string :content
			t.string :gift
			t.string :module_code
			t.integer :module_id
			t.string :deadline
			t.boolean :is_anonymous
			t.integer :status  , :default=>0
			t.integer :user_id

			t.integer :comments_count
			t.timestamps
		end
		add_index :microposts, [:user_id, :created_at]
	end
end