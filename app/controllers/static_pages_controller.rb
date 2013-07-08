class StaticPagesController < ApplicationController
  def home
    @hostname = request.host_with_port
    if signed_in?
      feed_user_items = current_user.feed
      feed_mod_items = current_user.mod_feed
      feed_items_join = (feed_user_items + feed_mod_items).uniq
      @feed_items = feed_items_join.paginate(page: params[:page],:per_page=>15)
      @microposts = Micropost.all.sort{|u,v| v.comments.count <=> u.comments.count}.first 10

    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def privacy
  end

end
