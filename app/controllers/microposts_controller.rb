class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
    @micropost = Micropost.find(params[:id])
    @user = User.find_by(id: @micropost.user_id)
    require 'date'
    if @micropost.deadline != ""
      @elapsed_unit = "day(s)"
      @elapsed_seconds = ((@micropost.deadline.to_time - Time.now) ).to_i
      if @elapsed_seconds < 0
        @elapsed_seconds = 0
      elsif @elapsed_seconds > 60*60*24
        @elapsed_seconds /= 60*60*24
      else 
        @elapsed_seconds =0
      end
    end
    @comments = @micropost.comments.paginate(page: params[:page],:per_page=>10)
  end

  def create
    # TODO: add check for the Deadline -- if it's according to the correct date format
    params[:micropost][:module_id] = NusModule.find_by(code: params[:micropost][:module_code]).id
    rescue Exception => exc
     logger.error("Message for the log file #{exc.message}")
     flash[:error] = "Invalid Module Code. Please use the auto-complete to select a correct one.!"
     redirect_to root_url
    else
    @micropost = Micropost.new(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      @micropost.create_activity :create, owner: current_user
    else
      flash[:error] = "Post unsuccessful."
    end
    redirect_to root_url
  end

  def update

  end

  def addClickCount
    @micropost = Micropost.find_by(:id => params[:post_id])
    Micropost.where(:id=>params[:post_id]).update_all("click_count = click_count + 1")
    return render json: @micropost
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private
    def micropost_params
      params.require(:micropost).permit(:title, :content, :user_id, :gift, :module_id, :is_online,
                                        :deadline, :is_anonymous, :status, :comments_attributes)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
