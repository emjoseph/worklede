class User < ActiveRecord::Base
  has_many :resumes

  def get_best_matches
      matches = []
      self.resumes.each{ |resume|
          resume_matches = resume.matches.order(:score).last(5).reverse

          resume_matches.each{ |match|
              match.job = Job.find(match.job_id)
          }

          # Filter out matches with old jobs
          date_filtered_matches = []
          resume_matches.each{ |match|
            if match.job.posted_days_ago_int < 20
              date_filtered_matches = date_filtered_matches + [match]
            end
          }

          matches = matches + date_filtered_matches
      }
      return matches
  end

  # Of the matches that have been completed, but for which the user hasn't received an email
  # => Send the user an email that contains those matches
  def get_new_matches
    matches = []
    self.resumes.each { |resume|
      #resume_matches = resume.matches.where(didEmail: nil, ).order(:score).reverse
      resume_matches = resume.matches.where(didEmail: nil).where('score > 0.88').order(:score).reverse

      resume_matches.each{ |match|
          match.job = Job.find(match.job_id)
      }

      # Filter out matches with old jobs
      date_filtered_matches = []
      resume_matches.each{ |match|
        if match.job.posted_days_ago_int < 10
          date_filtered_matches = date_filtered_matches + [match]
        end
      }

      matches = matches + date_filtered_matches
    }
    puts "YOLO"
    puts matches.length
    puts matches
    return matches
  end

  def get_new_matches_score_agnostic_for_testing
    matches = []
    self.resumes.each { |resume|
      #resume_matches = resume.matches.where(didEmail: nil, ).order(:score).reverse
      resume_matches = resume.matches.where(didEmail: nil).order(:score).reverse

      resume_matches.each{ |match|
          match.job = Job.find(match.job_id)
      }

      # Filter out matches with old jobs
      date_filtered_matches = []
      resume_matches.each{ |match|
        if match.job.posted_days_ago_int < 30
          date_filtered_matches = date_filtered_matches + [match]
        end
      }

      matches = matches + date_filtered_matches
    }
    puts "YOLO"
    puts matches.length
    puts matches
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

  def send_email_with_new_job_matches_test
    matches = self.get_new_matches_score_agnostic_for_testing
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
