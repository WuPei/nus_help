class CreateHelpRecs < ActiveRecord::Migration
  def change
    create_table :help_recs do |t|
      t.integer :helper_id
      t.string :helper_comment
      t.string :owner_comment
      t.boolean :is_happy

      t.timestamps
    end
  end
end
