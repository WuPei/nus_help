class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include PublicActivity::StoreController 
  #will recall the controller on each request
end
