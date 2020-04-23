namespace :workers do
  desc "Send emails to all our users with their latest matches"
  task send_match_emails: :environment do
    SendNewMatchesWorker.perform_in(0.seconds)
  end

  task score_new_jobs: :environment do
    ResumeMatchWorker.perform_in(0.seconds)
  end
end
