class Likeship < ActiveRecord::Base
  include PublicActivity::Model
  tracked :skip_defaults => true
  attr_accessible :liked_micropost_id, :liker_id

  belongs_to :liker, class_name: "User"
  belongs_to :liked_micropost, class_name: "Micropost"
  
  validates :liked_micropost_id, presence: true
  validates :liker_id , presence: true
end
