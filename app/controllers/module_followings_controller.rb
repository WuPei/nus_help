class ModuleFollowingsController < ApplicationController
  before_action :signed_in_user

  def new
    @module = get_user_module(params['token'])
    @mod = []
    for m in @module['Results']
      @mod.push({"code"=>m['CourseCode'], "name"=>m['CourseName']})
    end
    @uid = params['uid']
  end

  def create
    @module_following = ModuleFollowing.new(params[:module_following])
    if @module_following.save
      @module_following.create_activity :create, owner: current_user
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end


  def destroy
    @module_following = ModuleFollowing.find_by(params[:module_following])
    @module_following.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def insertModules
    if(params[:module])
      for m in params[:module]
        mod = NusModule.find_by(code: m['code'])
        unless mod.nil?
          params[:modFollow] = {:mod_id=>mod.id, :mod_follower_id=>params[:uid]}
          ModuleFollowing.create!(params[:modFollow])
        end
      end
    end
    user = User.find_by(id: params[:uid])
    if(user)
      redirect_back_or user
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
