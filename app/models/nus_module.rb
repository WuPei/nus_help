class NusModule < ActiveRecord::Base
  attr_accessible :name, :code, :description, :microposts_attributes, :followr_count

  has_many :module_followings, foreign_key: "mod_id", dependent: :destroy
  has_many :mod_followers, through: :module_followings
  has_many :microposts, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  accepts_nested_attributes_for :microposts, allow_destroy: false

  def feed
    Micropost.from_a_module(self)
  end

  def findModule(code)
    where("module_code = :module_code", module_code: code)
  end
      
  def following?(user)
    module_followings.find_by(mod_follower_id: user.id)
  end

  def follow!(user)
    module_followings.create!(mod_follower_id: user.id)
  end

  def unfollow!(user)
    module_followings.find_by(mod_follower_id: user.id).destroy
  end

end

