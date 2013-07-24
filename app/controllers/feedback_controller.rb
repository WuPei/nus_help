class FeedbackController < ApplicationController
  def create
    @feedback = Feedback.new
    @feedback.uid = current_user.id
    @feedback.from = request.env["HTTP_ORIGIN"]
    @feedback.content = params['content']
    if @feedback.save 
      flash[:success] = "Feedback Created!"
    else
      flash[:error] = "Sorry.. error occured while saving your feedback.."
    end

    render "created"
  end
end
