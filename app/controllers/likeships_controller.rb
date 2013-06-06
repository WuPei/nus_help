class LikeshipsController < ApplicationController
	def create
		@user = User.find(params[:likeship][:liker_id])
		@micropost=Micropost.find(params[:likeship][:liked_micropost_id])
		@micropost.like!(@user)
		redirect_to @user
	end
	 
end
