class AddIndexToNusModulesCode < ActiveRecord::Migration
  def change
  	add_index :nus_modules, :code, unique:true
  end
end
