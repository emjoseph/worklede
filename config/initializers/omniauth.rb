Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, ENV['LINKEDIN_CLIENT_ID'], ENV['LINKEDIN_CLIENT_SECRET']
  puts 'Initialized OmniAuth LinkedIn'
  puts ENV['HEROKU_DB_NAME']
  puts ENV['HEROKU_DB_PASSWORD']
  puts ENV['HEROKU_DB_NAME']
  puts ENV['MAILGUN_USERNAME']
  puts ENV['MAILGUN_PASSWORD']
  puts ENV['AWS_SES_SMTP_USERNAME']
  

end
