class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(params.require(:user).permit(:name, :email, :age, resumes: []))
    if @user.resumes.attached?
      @user.resumes.attach(params[:resumes])
    end
    bSave = @user.save
    if bSave == false
      @user.errors.full_messages
    end
    redirect_to @user
  end
  def show
    @user = User.find(params[:id])
 end
 def index
        @users = User.all
    end
end
