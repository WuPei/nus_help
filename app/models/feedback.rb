class Feedback < ActiveRecord::Base
  validates :uid, presence: true
  validates :content, presence: true
  validates :from, presence: true
end
