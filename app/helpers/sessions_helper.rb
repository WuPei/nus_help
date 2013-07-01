module SessionsHelper

  def sign_in(user)
    cookies[:remember_token] = { :value => user.remember_token, :expires => 365.days.from_now}
    current_user = user
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

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def validate_nus(token)
    url = "https://ivle.nus.edu.sg/api/Lapi.svc/Validate?APIKey=#{NusHelp::Application::API_KEY}&Token=#{token}";
    res = http_request(url)
    return res
  end

  def http_request(url)
    uri = URI.parse(url)
    # res = Net::HTTP.get(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # You should use VERIFY_PEER in production
    request = Net::HTTP::Get.new(uri.request_uri)
    res = http.request(request)
    return res
  end

  

  def get_user_name(token)
    url = "https://ivle.nus.edu.sg/api/Lapi.svc/UserName_Get?APIKey=#{NusHelp::Application::API_KEY}&Token=#{token}";
    res = http_request(url)
    return res.body[1..-2]
  end

  def get_user_account(token)
    url = "https://ivle.nus.edu.sg/api/Lapi.svc/UserID_Get?APIKey=#{NusHelp::Application::API_KEY}&Token=#{token}";
    res = http_request(url)
    return res.body[1..-2]
  end

  def get_user_email(token)
    url = "https://ivle.nus.edu.sg/api/Lapi.svc/UserEmail_Get?APIKey=#{NusHelp::Application::API_KEY}&Token=#{token}";
    res = http_request(url)
    return res.body[1..-2]
  end

  
end
