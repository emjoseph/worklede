class User < ActiveRecord::Base
  has_many :resumes

  def get_best_matches
      matches = []
      self.resumes.each{ |resume|
          resume_matches = resume.matches.order(:score).last(2).reverse
          resume_matches.each{ |match|
              match.job = Job.find(match.job_id)
              puts match.job
          }
          matches = matches + resume_matches
      }
      return matches
  end

  # Of the matches that have been completed, but for which the user hasn't received an email
  # => Send the user an email that contains those matches
  def get_new_matches
    matches = []
    self.resumes.each { |resume|
      resume_matches = resume.matches.where(didEmail: nil).order(:score).reverse
      matches = matches + resume_matches
    }
    return matches
  end

  def send_email_with_new_job_matches
    matches = self.get_new_matches

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

    UserMailer.with(user:self, jobs: jobs).new_matches_email.deliver

    # Mark matches as emailed
    matches.each {|match|
        match.didEmail = true
        match.save
    }
  end

  def send_welcome_email
    UserMailer.with(user:self).new_signup_email.deliver
  end

end
