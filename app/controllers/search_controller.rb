class SearchController < ApplicationController
  def index
    query = params[:search]
    @users = User.where('name LIKE ?', "%#{query}%").limit(20)
    @modules = NusModule.where('code LIKE ? OR name LIKE ? ', "%#{query}%","%#{query}%").limit(20)
    @microposts = Micropost.where('title LIKE ? OR content LIKE ? ', "%#{query}%","%#{query}%").limit(20)
    if(!query)
      @error = "Sorry You didn't specify anything to search for"
      return
    end
  end

  def show
  end

end
