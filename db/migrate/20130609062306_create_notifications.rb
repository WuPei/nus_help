class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :from_uid
      t.integer :to_uid
      t.text :content
      t.string :related_url
      t.integer :status

      t.timestamps
    end
  end
end
