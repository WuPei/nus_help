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

  def update
    @user = User.find(params[:id])
    unless params["user"].nil?
      u = params["user"]
      if !u.nil? and !u[:crop_x].blank? and !u[:crop_y].blank?  and !u[:crop_w].blank? and !u[:crop_h].blank?
        x,y,w,h = u[:crop_x],u[:crop_y],u[:crop_w],u[:crop_h]
      # Do cropping here -- duplicate image, save a smaller one
        bigFilePath = @user.photo.file.file
        img = MiniMagick::Image.open(bigFilePath)
        img.crop("#{w}x#{h}+#{x}x#{y}")
        # Save it to temp path
        basepath = (File.dirname bigFilePath) + "/thumbnails"
        (Dir.mkdir basepath, 0755) unless Dir.exist? basepath
        smaFilePath = basepath + "/" + (File.basename bigFilePath)
        img.resize "180x180"
        img.write smaFilePath
        File.chmod(0755,smaFilePath)
        @user.photo_small = smaFilePath
      # Create a file in the thumbnails folder, and save the username there
      end
    end

    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to edit_user_path @user # TODO: further editing needed here.
    else
      render 'edit'
    end
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
