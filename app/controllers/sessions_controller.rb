class SessionsController < ApplicationController

  def new
    #get nus token and validate student account
    require 'net/http'
    token = request.GET['token']
    res = validate_nus(token)

    #if success 
    if res.body["Success"]=="Success"
      account = get_user_account(token).downcase
      user = User.find_by(account: account)
      if(user)
       #if old user, go to user page directly
       sign_in user
       redirect_back_or user
      else
        #if new user, go to signup page to fill in information
        #get nus account, name, module
        #store token in database
        name = get_user_name(token)
        email = get_user_email(token)
        modules_info = get_user_module(token)

        #puts user_info
        mod = []
        for m in modules_info['Results']
          mod.push({"code"=>m['CourseCode'], "name"=>m['CourseName']})
        end
        redirect_to(signup_url(:name=>name, :email=>email, :account=>account, :module=>mod))
      end
    else
      redirect_to root_url
    end 
  end


  def destroy
    sign_out
    redirect_to root_url
  end
end
