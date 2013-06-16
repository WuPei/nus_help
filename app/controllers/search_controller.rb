class SearchController < ApplicationController
  def index
    query = params["query"]

    if(!query)
      @error = "Sorry You didn't specify anything to search for"
      return
    end

    @info = query
  end
end
