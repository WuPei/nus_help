class StaticPagesController < ApplicationController
  def home
    @hostname = request.host_with_port
    if signed_in?
      feed_user_items = current_user.feed
      feed_mod_items = current_user.mod_feed
      feed_items_join = (feed_user_items + feed_mod_items).uniq
      #show the new comers more microposts 
      if feed_items_join.count <= 5
        @feed_items = Micropost.all.paginate(page:params[:page], :per_page=>15)
      else
        @feed_items = feed_items_join.paginate(page: params[:page],:per_page=>15)
      end 
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
