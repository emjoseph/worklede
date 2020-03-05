require 'securerandom'

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

    @user = User.find(id=session[:user_id])
    @resume = @user.resumes.create()

    resume_file = params[:user][:resume_file]

    # 1. Upload file to /public/uploads
    fileUploadPath = Rails.root.join('public', 'uploads', resume_file.original_filename)
    puts "File upload path"
    puts(fileUploadPath)
    puts(resume_file)
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
      @resume.resume_link = s3Object.public_url
      @resume.save

      # 4. Delete file from public/uploads
      File.delete(fileUploadPath) if File.exist?(fileUploadPath)
      puts("Upload done!")

      redirect_to "/"

    end

    #@resume.resußme_file.attach(params[:user][:resume_file])
    #@resume.save
    #puts @resume.resume_file.blob.key
    #puts "https://worklede.s3.amazonaws.com/#{@resume.resume_file.blob.key}"
    #puts "SAVE"
    #puts @resume.resume_file.attached?
    #puts @resume.to_yaml


    #obj = AMAZON_S3_CLIENT('worklede').object('key')

  end


  private
    def resume_params
      puts "RESUME PARAMS METHOD"
      puts params
      params.require(:user).permit(:resume_file)
    end

end
