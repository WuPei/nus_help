class UsersController < ApplicationController
  before_action :signed_in_user,
    only: [:show, :index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  #show some users in lists
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

    helps = HelpRec.find_all_by_helper_id(@user.id)
    @microposts_help = []
    helps.each do |h|
      micpost = Micropost.find_by(id: h.post_id)
      @microposts_help.push(micpost)
    end
    @microposts_help = @microposts_help.paginate(page: params[:page])
  end

  def new
    @user = User.new
    @nus_module = NusModule.new
    @user.account = params['account']
    @user.name = params['name']
    @user.email = params['email']
    @modules = params['modules']
    @user.remember_token = params['remember_token']
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def json_upload
    @user = User.find(params[:id])
    # save this img
    render json: {:sts => 1, :msg => "Invalid User"} and return if current_user != @user or params[:image_file_ajax_uploader].nil?

    # Handle Image Upload from here on
    @user.user_img = UserImg.new if @user.user_img.nil?
    @user.user_img.save_upload(params[:image_file_ajax_uploader])
    render json: {:sts => 0, :src => @user.user_img.origin_name}
  end

  def update
    @user = User.find(params[:id])
    unless params["user_img"].nil?
      u = params["user_img"]
      
      if UserImg::cropFields?(u)
      # Do cropping here -- duplicate image, save a smaller one
        @user.user_img.save_croping(u)
      # Create a file in the thumbnails folder, and save the username there
      end
    end
    
    # Save This Image
    if params["user"] then
    end
    flash[:success] = "Update Succeeded."
    render 'edit'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the NUS HELP!"
      sign_in @user
      #redirect to add module
      redirect_to (insertModules_url(:token=>@user.remember_token, :uid=>@user.id, :account=>@user.account))
    else
      render 'new'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :account, :gender, :photo ,:microposts_attributes, :remember_token)
    end

    # Before filters

    def signed_in_user

      unless signed_in?
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
