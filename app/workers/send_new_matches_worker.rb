class SendNewMatchesWorker
  include Sidekiq::Worker
  def perform()
    puts "Sending New Matches"
    User.all.each {|user|
      user.send_email_with_new_job_matches
    }
  end
end
