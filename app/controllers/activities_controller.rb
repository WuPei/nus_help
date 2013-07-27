class ActivitiesController < ApplicationController

  def index
    @activities = PublicActivity::Activity.order("created_at desc").where("recipient_id = (:user_id)", user_id: current_user.id)
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
