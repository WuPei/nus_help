class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  include PublicActivity::StoreController 
  #will recall the controller on each request

  before_filter :basic_setup
  before_filter :record_visitor_info

private

  def basic_setup
    @micropost = Micropost.new
  end

  def record_visitor_info
    rec = VisitorInfo.new
    rec.ip = request.remote_ip
    rec.method = request.env["REQUEST_METHOD"]
    rec.path = request.env["ORIGINAL_FULLPATH"]
    rec.user_agent = request.env["HTTP_USER_AGENT"].slice(0,253)
    rec.uid = current_user.id if current_user
    rec.save!

    # p request.remote_ip
  end
end
