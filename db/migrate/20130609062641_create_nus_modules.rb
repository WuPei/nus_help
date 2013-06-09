class CreateNusModules < ActiveRecord::Migration
  def change
    create_table :nus_modules do |t|
      t.string :name
      t.string :code
      t.text :description

      t.timestamps
    end
  end
end
