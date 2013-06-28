class NusModulesController < ApplicationController
  def index
    if params[:search] and params[:search].strip!=""
      @searched_modules = NusModule.where('code LIKE ? OR name LIKE ?', "%#{params[:search]}%","%#{params[:search]}%")
    else  
      @searched_modules = NusModule.find(:all)
    end 
    @nus_modules = NusModule.paginate(page: params[:page])
  end

  def autoCompJson
    @nus_modules = NusModule.order(:code).where("code like ?", "%#{params[:term]}%")
    render json: @nus_modules.map(&:code)
  end

  def show
    @nus_module = NusModule.find(params[:id])
    @feed_items = @nus_module.feed.paginate(page: params[:page])
    #@microposts = @nusModules.microposts.paginate(page: params[:page])
  end

  def new
    @nus_module = NusModule.new
  end

  def create
    @nus_module = NusModule.new(params[:nus_module])
    if @nus_module.save
      flash[:success] = "Module Created successfully !"
      redirect_to @nus_module# Handle a successful save.
    else
      render 'new'
    end
  end

end
