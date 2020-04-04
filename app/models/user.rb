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

  def send_welcome_email
    UserMailer.with(user:self).new_signup_email.deliver
  end

end
