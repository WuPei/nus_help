class CommentsController < ApplicationController

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.create({:content => params[:comment][:content] ,
                                           :user_id => current_user.id})
    if @comment.save
      @comment.create_activity :create, owner: current_user
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @comment=Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  def show
    @comment = Comment.find(params[:id])
  end

end
