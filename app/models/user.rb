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
	before_save { self.email = email.downcase }
	before_save :create_remember_token
	before_create { generate_token(:auth_token) }
	attr_accessible :name, :email, :password, :password_confirmation
	has_secure_password

   def send_password_reset
     generate_token(:password_reset_token)
     self.password_reset_sent_at = Time.zone.now
     save!
     UserMailer.password_reset(self).deliver
   end

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
	def generate_token(column)
     begin
       self[column] = SecureRandom.urlsafe_base64
     end while User.exists?(column => self[column])
   end
end
