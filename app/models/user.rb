# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  attr_accessible :name, :email, :account, :remember_token, :photo, :microposts_attributes, :gender
  mount_uploader :photo, ImageUploader
  has_many :comments 
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_likeships, foreign_key: "liker_id", class_name: "Likeship", dependent: :destroy
  has_many :liked_microposts, through: :reverse_likeships
  has_many :reverse_module_followings, foreign_key: "mod_follower_id", class_name: "ModuleFollowing", dependent: :destroy
  has_many :mods, through: :reverse_module_followings

  accepts_nested_attributes_for :microposts, allow_destroy: true
  before_save { self.email = email.downcase }
  # before_save :create_remember_token


  before_save { |user| user.email = email.downcase }
  validates :account, presence: true, uniqueness: { case_sensitive: false }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :remember_token, presence: true
  validates :gender, presence:true

  def feed
    Micropost.from_users_followed_by(self)
  end

  def mod_feed
    Micropost.from_modules_following(self)
  end

  def findModule(code)
    NusModule.findModule(code)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end


  # private

  #   def create_remember_token
  #     self.remember_token = SecureRandom.urlsafe_base64
  #   end
end
