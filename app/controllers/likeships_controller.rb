class LikeshipsController < ApplicationController
	def create
		@likeship = Likeship.new(params[:likeship])
		if @likeship.save
			redirect_to :back
		end
	end
	 
	def destroy
		@likeship = Likeship.find_by(params[:likeship])
		@likeship.destroy
		redirect_to :back
	end
end
