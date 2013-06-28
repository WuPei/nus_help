class AddPostIdIntoHelpRecs < ActiveRecord::Migration
  def change
  	add_column :help_recs, :post_id, :integer
  end
end
