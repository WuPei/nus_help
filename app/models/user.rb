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
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :followed_users, through: :relationships, source: :followed
  
  #has_many :reverse_likeships, foreign_key: "liked_micropost_id", class_name: "Likeship", dependent: :destroy
  #has_many :liked_microposts, through: :reverse_likeships, source: :liked_micropost

  accepts_nested_attributes_for :microposts, allow_destroy: true
  before_save { self.email = email.downcase }
  before_save :create_remember_token

  attr_accessible :name, :email, :password, :password_confirmation , :microposts_attributes
  has_secure_password

  before_save { |user| user.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    Micropost.from_users_followed_by(self)
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

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
