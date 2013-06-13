class CreateNusModules < ActiveRecord::Migration
  def change
    create_table :nus_modules do |t|
      t.string :name
      t.string :code
      t.text :description

      t.timestamps
    end
    add_index :nus_modules, :code, unique:true
  end
end
