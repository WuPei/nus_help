class ModuleFollowingsController < ApplicationController
  before_action :signed_in_user

  def create
    @module_following = ModuleFollowing.new(params[:module_following])
    if @module_following.save
      redirect_to :back
    end
  end

  def destroy
    @module_following = ModuleFollowing.find_by(params[:module_following])
    @module_following.destroy
    redirect_to :back
  end
end
