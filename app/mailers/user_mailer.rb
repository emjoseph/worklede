


class UserMailer < ApplicationMailer
    default from: 'Team Dispatch <dispatch@worklede.com>'
    def new_resume_email
        @user = params[:user]
        @url  = 'http://localhost:3000'
        mail(to: @user.email, subject: 'WorkLede: New Resume Uploaded')
    end

    def new_signup_email
        @user = params[:user]
        @url  = 'http://localhost:3000'
        mail(to: @user.email, subject: 'Welcome to WorkLede!')
    end

    def new_matches_email
        @user = params[:user]
        @jobs = params[:jobs]
        @url  = 'http://localhost:3000'
        mail(to: @user.email, subject: 'WorkLede: Latest Job Matches')
    end
end
