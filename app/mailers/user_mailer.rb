

  
class UserMailer < ApplicationMailer
    default from: 'admin@worklede.com'

    def new_resume_email
        @user = params[:user]
        @url  = 'http://localhost:3000'
        mail(to: @user.email, subject: 'New Resume Uploaded')
    end
end