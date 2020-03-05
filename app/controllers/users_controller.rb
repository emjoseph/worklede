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

  def update()
    puts "UPDATE USER"
    puts params
    @user = User.find(id=session[:user_id])

    @resume = @user.resumes.create(resume_params)
    @resume.resume_file.attach(params[:user][:resume_file])
    @resume.save
    puts @resume.resume_file.blob.key
    puts "https://worklede.s3.amazonaws.com/#{@resume.resume_file.blob.key}"
    puts "SAVE"
    puts @resume.resume_file.attached?
    puts @resume.to_yaml  end


  private
    def resume_params
      puts "RESUME PARAMS METHOD"
      puts params
      params.require(:user).permit(:resume_file)
    end

end
