module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  #the user’s signin status would be forgotten: 
  #as soon as the user went to another page—poof!—the session would end and 
  #the user would be automatically signed out.
  #calls the find_by method the first time current_user is called, 
  #but on subsequent invocations returns @current_user without hitting the database.
  #as later the @current_user is not false again 
  def current_user
    @current_user ||= User.find_by(remember_token: cookies[:remember_token])
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
