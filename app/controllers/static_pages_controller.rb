class StaticPagesController < ApplicationController
  def home
    if signed_in?
      feed_user_items = current_user.feed
      feed_mod_items = current_user.mod_feed
      feed_items_join = (feed_user_items + feed_mod_items).uniq
      #one bug: the feed_item cannot be paginated. need find a solution 
      @feed_items = feed_items_join.paginate(page: params[:page],:per_page=>15)
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
