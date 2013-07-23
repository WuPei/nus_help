class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :uid
      t.string :content
      t.string :from

      t.timestamps
    end
  end
end
