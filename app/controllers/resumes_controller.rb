require 'securerandom'

class ResumesController < ApplicationController
    def destroy
        @user = User.find(id=session[:user_id])
        @resume = @user.resumes.find(params[:id])
        @resume.destroy
        redirect_to user_path(@user)
    end

    def create
      @user = User.find(id=session[:user_id])
      @resume = @user.resumes.create()
      @resume.name = params[:resume_name]
      resume_file = params[:resume_file]

      # 1. Upload file to /public/uploads
      # puts(params.to_yaml)
      # puts(resume_file)
      fileUploadPath = Rails.root.join('public', 'uploads', resume_file.original_filename)

      File.open(fileUploadPath, 'wb') do |file|
        file.write(resume_file.read)

        # 2. Upload file to worklede s3 bucket
        s3 = Aws::S3::Resource.new(
              credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_KEY']),
              region: 'us-east-1'
        )

        s3FileExtension = resume_file.original_filename.split('.')[1]
        s3FileName = SecureRandom.uuid + "-resume." + s3FileExtension

        s3Object = s3.bucket('worklede').object(s3FileName)
        s3Object.upload_file(fileUploadPath, acl:'public-read')

        # 3. Save resume s3 link on DB
        @resume.s3_link = s3Object.public_url

        # 4. Send an email to user if resume is uploaded successfully
        @resume.save
        if @resume.save
            # Tell the UserMailer to send a welcome email after save
            puts @user.email
            UserMailer.with(user: @user).new_resume_email.deliver
            redirect_to "/"
        else
          redirect_to "/"
        end

        # 5. Call Python script to get json string
        json_str = `python3 nlp/resume_parser.py "#{fileUploadPath}"`
        puts json_str
        @resume.resume_txt = json_str
        @resume.save
        #@resume.get_job_matches_spacey

        # 6. Delete text file if it exists in public/text-uploads
        File.delete(fileUploadPath) if File.exist?(fileUploadPath)
        #File.delete(txtFileUploadPath) if File.exist?(txtFileUploadPath)
      end
    end

    private
      def resume_params
        params.require(:user).permit(:resume_file, :resume_name)
      end
end
