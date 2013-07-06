class Relationship < ActiveRecord::Base
 include PublicActivity::Model
 #tracked :skip_defaults => true
 tracked owner: ->(controller, model) { controller && controller.current_user } 

  attr_accessible :follower_id, :followed_id
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
