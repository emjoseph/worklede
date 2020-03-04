class LoginController < ApplicationController

  def callback
    begin
      oauth = OauthService.new(request.env['omniauth.auth'])
      if oauth_account = oauth.create_oauth_account!
          puts "Succesfully Logged In"
          redirect_to resumes_path, notice: "Succesfully logged on."
      end
    rescue => e
      puts "Login error"
      flash[:alert] = "There was an error while trying to authenticate your account."
      redirect_to resumes_path, notice: "There was an error while trying to authenticate your account."
    end
  end

  def failure
    puts "Login error"
    flash[:alert] = "There was an error while trying to authenticate your account."
    redirect_to resumes_path, notice:"There was an error while trying to authenticate your account."
  end

end
