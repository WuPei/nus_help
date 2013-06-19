class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
    @micropost = Micropost.find(params[:id])
  end

  def create
    params[:micropost][:module_id] = NusModule.find_by(code: params[:micropost][:module_code]).id
    rescue Exception => exc
     logger.error("Message for the log file #{exc.message}")
     flash[:notice] = "Invalid module id! You should follow the module first!"
     redirect_to root_url
    else
    @micropost = Micropost.new(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      @micropost.create_activity :create, owner: current_user
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end

  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:title, :content, :user_id, :gift, :module_id,
                                        :deadline, :is_anonymous, :status, :comments_attributes)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
