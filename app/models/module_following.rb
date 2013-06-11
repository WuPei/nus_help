class ModuleFollowing < ActiveRecord::Base
	attr_accessible :mod_id, :mod_follower_id, :mod_code

	belongs_to :mod_follower, class_name: "User"
	belongs_to :followed_mod, class_name: "Nus_module"

	validates :mod_follower_id, presence: true
	validates :mod_id, presence: true
	validates :mod_code, presence: true
end
