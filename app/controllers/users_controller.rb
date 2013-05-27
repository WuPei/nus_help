class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :edit, :update]
	before_action :correct_user,   only: [:edit, :update]

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
	end

	def edit
		#@user = User.find(params[:id])
	end

	def update
		#@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			sign_in @user
			redirect_to @user
		else
			render 'edit'
		end
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Welcome to the NUS HELP!"
			redirect_to @user# Handle a successful save.
		else
			render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password,
		:password_confirmation)
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password,
		:password_confirmation)
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
end
