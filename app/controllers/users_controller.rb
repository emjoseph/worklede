require 'securerandom'

class UsersController < ApplicationController

  def index
    # If not logged in redirect to homepage
    puts params
    puts session[:user_id]
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
    session.clear
    redirect_to "/"
  end

  def show()
    if session[:user_id].to_i == params[:id].to_i
      @latest_jobs = Job.order(:posted_days_ago_int).first(5)
      @user = User.find(id=params[:id])
    else
      redirect_to "/"
    end
  end

end
