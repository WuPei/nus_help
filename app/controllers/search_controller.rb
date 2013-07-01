class SearchController < ApplicationController
  def index
    query = params[:search]
    if query.nil? or query == "" then
      return
    end
    term = params[:term]
    @users = User.where('name LIKE ?', "%#{query}%").limit(20)
    if query =~ /\w{2,3}\d{0,4}/
      @modules = NusModule.where('code LIKE ?', "%#{query}%").limit(20)
    else
      @modules = NusModule.where('code LIKE ? OR name LIKE ? ', "%#{query}%","%#{query}%").limit(20)
    end
    @microposts = Micropost.where('title LIKE ? OR content LIKE ? ', "%#{query}%","%#{query}%").limit(20)
    if(!query)
      @error = "Sorry You didn't specify anything to search for"
      return
    end
  end

  def show
  end

end
