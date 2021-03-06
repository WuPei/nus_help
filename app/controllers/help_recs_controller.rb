class HelpRecsController < ApplicationController
  before_action :signed_in_user

  def create
    @helpRec = HelpRec.new(params[:help_rec])
    if @helpRec.save
      @helpRec.create_activity :create, owner: current_user, recipient: @helpRec.post.user
      redirect_to :back
    end
  end

  def destroy
    @helpRec = HelpRec.find_by(params[:help_rec])
    @helpRec.destroy
    redirect_to :back
  end

  def update
    #choose helper
    @helpRec = HelpRec.find(params[:rec_id])
    if @helpRec.update_attributes(params)
      flash[:success] = "Help updated"
      post_id = @helpRec.post_id
      @micropost = Micropost.find_by(:id=>post_id)
      if @micropost.update_attributes(:status => 1, :helper_id => @helpRec.helper_id)              
        @helpRec.create_activity :update, owner: current_user, recipient: @helpRec.helper
        redirect_to @micropost
        flash[:success] = "Help updated"
      else
        redirect_to :back
      end
    else
      redirect_to :back
    end
  end

  def feedback
    #feedback happy or not
    @helpRec = HelpRec.find(params[:rec_id])
    if @helpRec.update_attributes(params)
      flash[:success] = "Help updated"
      post_id = @helpRec.post_id
      @micropost = Micropost.find_by(:id=>post_id)
      if @micropost.update_attributes(:status => 2, :is_happy => true) 
        @helpRec.create_activity :feedback, owner: current_user, recipient: @micropost.user            
        redirect_to @micropost
        flash[:success] = "Help updated"
      else
        redirect_to :back
      end
    else
      redirect_to :back
    end
  end

end