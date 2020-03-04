class UsersController < ApplicationController

  def index
    puts "INDEX CALLED"

    # If not logged in redirect to homepage
    @logged_in_user_id = session[:user_id]
    if @logged_in_user_id
      redirect_to user_path({:id => @logged_in_user_id})
    end

  end

  def new
  end

  def finish
  end

  def logout
    puts "LOG OUT CALLED"
    session.clear
    redirect_to "/"
  end

  def show()
    puts params
    @user = User.find(id=params[:id])
  end

end