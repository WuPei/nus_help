class ModuleFollowingsController < ApplicationController
  before_action :signed_in_user

  def new
    @user = current_user
  end

  def create
    if(params[:mode] == "module")
      params[:mode] == ""
      params[:module_following][:mod_follower_id] = current_user.id
      mod_code = params[:module_following][:mod_id]
      params[:module_following][:mod_id] = NusModule.find_by(:code => mod_code).id
    end
    respond_to do |format|
      if @module_following.save
        format.html { 
          @module_following.create_activity :create, owner: current_user
          redirect_to :back 
        }
        format.json{
          render json: @module_following,
          status: :created,
          location: @module_following
        }
      end
    end
  end

  def destroy
    if(params[:mode] == "module")
      params[:mode] == ""
      params[:module_following][:mod_follower_id] = current_user.id
      mod_code = params[:module_following][:mod_id]
      params[:module_following][:mod_id] = NusModule.find_by(:code => mod_code).id
    end
    @module_following = ModuleFollowing.find_by(params[:module_following])
    @module_following.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json{
        render json: @module_following,
        status: :deleted,
        location: @module_following
      }

    end
  end

  def insertModules
    @module = get_user_module(params['token'])
    @module_token = get_token_modules(params['token'],params['account'])
    @mod = []
    for m in @module['Results']
      @mod.push({"code"=>m['CourseCode'], "name"=>m['CourseName']})
    end

    for m in @module_token['Results']
      @mod.push({"code"=>m['ModuleCode'], "name"=>m['ModuleTitle']})
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

  def get_token_modules(token,studentID)
    url = "https://ivle.nus.edu.sg/api/Lapi.svc/Modules_Taken?APIKey=x1oWBE5VN7HEynShRRjLv&AuthToken=#{token}&StudentID=#{studentID}";
    res = http_request(url)
    return ActiveSupport::JSON.decode(res.body)
  end

end
