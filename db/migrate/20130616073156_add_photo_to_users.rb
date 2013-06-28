class AddPhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo, :string, :default => "0"
  end
end
