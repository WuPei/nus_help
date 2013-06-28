class Comment < ActiveRecord::Base
  include PublicActivity::Model
  tracked :skip_defaults => true
  #tracked except: :update, owner: ->(controller, model) { controller && controller.current_user }
  attr_accessible :content, :micropost_id, :user_id
  belongs_to :micropost, :counter_cache => true
end
