class ModuleFollowingsController < ApplicationController
  before_action :signed_in_user

  def new
    @user = current_user
  end

  def create
    nus_module = NusModule.find(params[:module_following][:mod_id])
    nus_module.follow!(current_user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    nus_module = ModuleFollowing.find_by(params[:id]).mod
    nus_module.unfollow!(current_user)
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

  def insertModules
    @module = get_user_module(params['token'])
    @mod = []
    for m in @module['Results']
      @mod.push({"code"=>m['CourseCode'], "name"=>m['CourseName']})
    end
    @uid = params['uid']
    if @mod
      for m in @mod
        mod = NusModule.find_by(code: m['code'])
        unless mod.nil?
          params[:modFollow] = {:mod_id=>mod.id, :mod_follower_id=>params[:uid]}
          ModuleFollowing.create!(params[:modFollow])
        end
      end
    end
    user = User.find_by(id: params[:uid])
    if(user)
      render :new
    else
      redirect_to root_url
    end
  end

  def get_user_module(token)
    url = "https://ivle.nus.edu.sg/api/Lapi.svc/Modules?APIKey=x1oWBE5VN7HEynShRRjLv&AuthToken=#{token}&Duration=10&IncludeAllInfo=false";
    res = http_request(url)
    return ActiveSupport::JSON.decode(res.body)
  end

end
