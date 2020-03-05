class ResumesController < ApplicationController
    def destroy
        @user = User.find(id=session[:user_id])
        @resume = @user.resumes.find(params[:id])
        @resume.destroy
        redirect_to user_path(@user)
      end
end
