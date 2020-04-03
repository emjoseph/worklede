


class UserMailer < ApplicationMailer
    default from: 'Team Dispatch <dispatch@worklede.com>'
    def new_resume_email
        @user = params[:user]
        @url  = 'http://localhost:3000'
        mail(to: @user.email, subject: 'WorkLede: New Resume Uploaded')
    end
end
