class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.text :remember_token
      t.string :account

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :account ,unique: true
  end
end
