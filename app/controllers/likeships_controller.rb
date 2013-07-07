class LikeshipsController < ApplicationController
  before_action :signed_in_user

  def create
    @likeship = Likeship.new(params[:likeship])
    if @likeship.save
      @likeship.create_activity :create, owner: current_user, recipient: @likeship.liked_micropost.user
      redirect_to :back
    end
  end

  def destroy
    @likeship = Likeship.find_by(params[:likeship])
    @likeship.destroy
    redirect_to :back
  end
end
