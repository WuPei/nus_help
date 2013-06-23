class HelpRecsController < ApplicationController
  before_action :signed_in_user

  def create
    @helpRec = HelpRec.new(params[:help_rec])
    if @helpRec.save
      @helpRec.create_activity :create, owner: current_user
      redirect_to :back
    end
  end

  def destroy
    @helpRec = HelpRec.find_by(params[:help_rec])
    @helpRec.destroy
    redirect_to :back
  end

end