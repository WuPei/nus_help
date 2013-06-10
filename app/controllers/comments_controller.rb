class CommentsController < ApplicationController
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.create({:content => params[:comment][:content] ,
                                           :user_id => current_user.id})
    redirect_to :back
  end
end
