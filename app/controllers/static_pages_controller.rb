class StaticPagesController < ApplicationController
  def home
    puts "q11111"
    puts current_user
    if signed_in?
      @micropost  = Micropost.new
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
