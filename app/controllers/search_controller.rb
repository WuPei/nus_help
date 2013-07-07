class SearchController < ApplicationController

  SearchLimit = 20

  def index
    return
    query = params[:search]
    if query.nil? or query == "" then
      return
    end
    term = params[:term]
    if(!query)
      @error = "Sorry You didn't specify anything to search for"
      return
    end
  end

  def show
    @term = params[:term]
    @query = params[:q]
    
    if @query.nil? or @query == "" then
      @query = nil
      return
    end

    # terms = {:module => ""}
    # Term Mapping with Switch case

    if @term.nil? then
      @users = User.where('name LIKE ?', "%#{query}%").limit(20)
      if query =~ /\w{2,3}\d{0,4}/
        @modules = NusModule.where('code LIKE ?', "%#{query}%").limit(20)
      else
        @modules = NusModule.where('code LIKE ? OR name LIKE ? ', "%#{query}%","%#{query}%").limit(20)
      end
      @microposts = Micropost.where('title LIKE ? OR content LIKE ? ', "%#{query}%","%#{query}%").limit(20)
    elsif @term == "module"
    elsif @term == "user"
    elsif @term == "post"
    end

  end

end
