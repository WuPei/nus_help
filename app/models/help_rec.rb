class HelpRec < ActiveRecord::Base
	include PublicActivity::Model
	tracked :skip_defaults => true
	attr_accessible :helper_id, :post_id, :helper_comment, :onwer_comment, :is_happy

	belongs_to :helper, class_name: "User"
	belongs_to :helped_micropost, class_name: "Micropost"
	  
	validates :helper_id, presence: true
	validates :post_id , presence: true
end
