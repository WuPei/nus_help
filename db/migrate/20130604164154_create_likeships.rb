class CreateLikeships < ActiveRecord::Migration
  def change
    create_table :likeships do |t|
      t.integer :liked_micropost_id
      t.integer :liker_id

      t.timestamps
    end
  add_index :likeships, :liked_micropost_id
  add_index :likeships, :liker_id
  add_index :likeships, [:liked_micropost_id, :liker_id], unique: true
  end
end
