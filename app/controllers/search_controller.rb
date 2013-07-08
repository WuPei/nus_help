class SearchController < ApplicationController

  SearchLimit = 18

  def show
    @query = params[:search]
    
    if @query.nil? or @query == "" then
      @query = nil
      return
    end

    # terms = {:module => ""}
    # Term Mapping with Switch case

    @users = User.where('name LIKE ?', "%#{@query}%").limit(SearchLimit)
    @usersc = User.where('name LIKE ?', "%#{@query}%").count
    @modules = NusModule.where('code LIKE ? OR name LIKE ? ',"%#{@query}%","%#{@query}%").limit(SearchLimit)
    @modulesc = NusModule.where('code LIKE ? OR name LIKE ? ',"%#{@query}%","%#{@query}%").count
    @microposts = Micropost.where('title LIKE ? OR content LIKE ? ', 
                                  "%#{@query}%","%#{@query}%").limit(SearchLimit)
    @micropostsc = Micropost.where('title LIKE ? OR content LIKE ? ', 
                                  "%#{@query}%","%#{@query}%").count
  end

  def show_term
    @term = params[:term]; @query = params[:search]
    return if @query.nil? or @query == "" 
    if @term == "module"
      if @query =~ /\w{2,3}\d{0,4}/
        @result = NusModule.where('code LIKE ?', "%#{@query}%")
      else
        @result = NusModule.where('code LIKE ? OR name LIKE ? ',
                                  "%#{@query}%","%#{@query}%").limit(SearchLimit)
      end
    elsif @term == "user"
      @result = User.where('name LIKE ?', "%#{@query}%").limit(SearchLimit)
    elsif @term == "post"
      @result = Micropost.where('title LIKE ? OR content LIKE ? ',
                                "%#{@query}%","%#{@query}%").limit(SearchLimit)
    else
      @result = nil
    end
    @usersc = User.where('name LIKE ?', "%#{@query}%").count
    @modulesc = NusModule.where('code LIKE ? OR name LIKE ? ',"%#{@query}%","%#{@query}%").count
    @micropostsc = Micropost.where('title LIKE ? OR content LIKE ? ', 
                                  "%#{@query}%","%#{@query}%").count
    @result = @result.paginate(page:params[:page], per_page: SearchLimit) unless @result.nil?
  end

end
