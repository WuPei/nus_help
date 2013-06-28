class ModuleFollowing < ActiveRecord::Base
  include PublicActivity::Model
  tracked :skip_defaults => true
  attr_accessible :mod_id, :mod_follower_id

  belongs_to :mod_follower, class_name: "User"
  belongs_to :mod, class_name: "NusModule"

  validates :mod_follower_id, presence: true
  validates :mod_id, presence: true
end
