class ActivitiesController < ApplicationController

  def index
  	followed_user_ids = "SELECT followed_id FROM relationships
                          WHERE follower_id = :user_id"
    @activities = PublicActivity::Activity.order("created_at desc").where("owner_id IN (#{followed_user_ids})", user_id: current_user.id)
  end

  def updateStatus
  	@activity = PublicActivity::Activity.find_by(:id => params[:activity_id])
 	  PublicActivity::Activity.where(:id=>params[:activity_id]).update_all("status = false")
  	respond_to do |format|
      format.html{
        redirect_to :back
      }
      format.json{
        head :no_content
      }	
    end
  end

end
