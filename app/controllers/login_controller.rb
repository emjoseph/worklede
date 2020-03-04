class LoginController < ApplicationController

  def callback
    begin
      oauth = OauthService.new(request.env['omniauth.auth'])
      if user = oauth.create_oauth_account!
          puts "Succesfully Logged In"
          session[:user_id] = user[:id]
          redirect_to "/", notice: "Succesfully logged on."
      end
    rescue => e
      puts "Login error"
      puts e
      flash[:alert] = "There was an error while trying to authenticate your account."
      redirect_to "/", notice: "There was an error while trying to authenticate your account."
    end
  end

  def failure
    puts "Login error"
    flash[:alert] = "There was an error while trying to authenticate your account."
    redirect_to "/", notice:"There was an error while trying to authenticate your account."
  end

end
