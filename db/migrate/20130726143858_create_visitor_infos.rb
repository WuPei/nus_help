class CreateVisitorInfos < ActiveRecord::Migration
  def change
    create_table :visitor_infos do |t|
      t.string :ip
      t.integer :uid
      t.string :method
      t.text :path
      t.text :user_agent

      t.timestamps
    end
  end
end
