
class Micropost < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  
  attr_accessible :title, :content, :user_id, :gift, :module_id, :deadline, :is_anonymous, :status, :comments_attributes, :module_code, :click_count, :helper_id, :is_happy
  belongs_to :user
  belongs_to :nus_module
  has_many :comments, dependent: :destroy
  has_many :likeships, foreign_key: "liked_micropost_id", dependent: :destroy
  has_many :likers, through: :likeships
  has_many :help_recs, foreign_key: "post_id", dependent: :destroy
  has_many :helpers, through: :help_recs

  accepts_nested_attributes_for :comments, allow_destroy: true

  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: {maximum: 25}
  validates :user_id, presence: true
  #validates_associated :nus_module
  validates :deadline, presence: true
  validates_date :deadline
  #validates :nus_module, :presence => {:message => 'The module no exists in NUS!'}
  validates :gift, presence: true
  validates :content, presence: true, length: { maximum: 200 }

  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end

  def self.from_a_module(nus_module)
    where("module_id = :module_id", module_id: nus_module.id )
  end

  def self.from_modules_following(user)
    following_module_ids = "SELECT mod_id FROM module_followings
                              WHERE mod_follower_id = :user_id"
    where("module_id IN (#{following_module_ids})", user_id: user.id)
  end

  def help?(user)
    help_recs.find_by(helper_id: user.id)
  end

  def help!(user)
    help_recs.create!(helper_id: user.id)
  end

  def unhelp!(user)
    help_recs.find_by(helper_id: user.id).destroy
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
