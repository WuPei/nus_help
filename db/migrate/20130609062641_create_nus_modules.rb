class CreateNusModules < ActiveRecord::Migration
  def change
    create_table :nus_modules do |t|
      t.string :name
      t.string :code
      t.text :description
      t.integer :follower_count, :default => 0

      t.timestamps
    end
    add_index :nus_modules, :code, unique:true
    add_index :nus_modules, :follower_count
  end
end
