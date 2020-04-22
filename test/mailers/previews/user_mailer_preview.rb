# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def testNewMatchesEmail
      user = User.first
      matches = user.get_new_matches

      # No new matches -> nothing to email
      if matches.length == 0
        puts "No new matches - nothing to email"
        return
      end

      # Get jobs from new matches
      jobs = []
      matches.each {|match|
          job = Job.find(match.job_id)
          puts job
          jobs = jobs + [job]
      }

      UserMailer.with(user:user, jobs: jobs).new_matches_email.deliver
    end
end
