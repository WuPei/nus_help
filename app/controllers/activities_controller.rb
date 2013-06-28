class ActivitiesController < ApplicationController
 
  def index
  	followed_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id"
    @activities = PublicActivity::Activity.order("created_at desc").where("owner_id IN (#{followed_user_ids})", user_id: current_user.id)
  end
end
