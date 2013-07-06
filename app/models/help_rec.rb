class HelpRec < ActiveRecord::Base
	include PublicActivity::Model
	tracked :skip_defaults => true
	attr_accessible :helper_id, :post_id, :helper_comment, :owner_comment, :feedback_comment, :is_happy, :contact_info, :online

	belongs_to :helper, class_name: "User"
	belongs_to :post, class_name: "Micropost"
	  
	validates :helper_id, presence: true
	validates :post_id , presence: true
end
