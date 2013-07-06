class RelationshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    @relationship = Relationship.find_by(followed_id: @user.id, follower_id: current_user.id)
    @relationship.create_activity :create, owner: current_user, recipient: @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end  
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
