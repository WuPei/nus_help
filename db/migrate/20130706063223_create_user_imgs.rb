class CreateUserImgs < ActiveRecord::Migration
  def change
    create_table :user_imgs do |t|
      t.integer :user_id
      t.string :origin
      t.string :cropped
      t.integer :cx
      t.integer :cy
      t.integer :cw
      t.integer :ch

      t.timestamps
    end
  end
end
