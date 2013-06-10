class NusModulesController < ApplicationController
  def index
    @nus_modules = NusModule.paginate(page: params[:page])
  end

  def show
    @nus_module = NusModule.find(params[:id])
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
