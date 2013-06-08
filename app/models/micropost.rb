class Micropost < ActiveRecord::Base
  attr_accessible :content, :user_id, :gift, :module_code,
    :deadline, :is_anonymous, :status, :comments_attributes
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likeships, foreign_key: "liked_micropost_id", dependent: :destroy
  has_many :likers, through: :likeships

  accepts_nested_attributes_for :comments, allow_destroy: true

  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :deadline, presence: true
  validates :gift, presence: true
  validates :content, presence: true, length: { maximum: 200 }

  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
 	                        WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

  def like?(user)
    likeships.find_by(liker_id: user.id)
  end

  def like!(user)
    likeships.create!(liker_id: user.id)
  end

  def unlike!(user)
    likeships.find_by_liker_id(user.id).destroy
  end
end
