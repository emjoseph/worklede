class ResumeMatchWorker
  include Sidekiq::Worker
  def perform()
    puts "Performing Matches on New Jobs"
    User.all.each {|user|
      user.resumes.first.get_job_matches_spacey
    }
  end
end
