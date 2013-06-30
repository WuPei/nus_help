class AddPhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo, :string, :null => true
    add_column :users, :photo_small, :string, :null => true
  end
end
