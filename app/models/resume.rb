require 'pp'

class Resume < ApplicationRecord
  belongs_to :user
  has_many :matches

  def get_job_matches
      puts "Getting job matches"

      resume_json = JSON.parse(self.resume_txt)

      nouns = resume_json['nouns']
      orgs = resume_json['organizations']
      verbs = resume_json['verbs']

      score_words = nouns + orgs + verbs

      scores = []
      jobs = []
      matched_words_master = []

      Job.all.each { |job|
        score = 0
        matched_words = []
        job.desc.split(' ').each { |word|
           if score_words.include? word
              score += 1
              matched_words.append(word)
           end
        }
        scores.append(score)
        jobs.append(job)
        matched_words_master.append(matched_words)
      }

      #puts "FINISHED"
      #puts "Resume Scores:"
      #puts scores

      max = scores.each_with_index.max(2)

      puts "#{scores}"
      puts "#{max}"
      puts "#{jobs}"
      best_job = jobs[max[0][1]]
      best_job_2 = jobs[max[1][1]]
      #puts best_job_words
      #puts best_job.desc

      puts best_job
      match1 = Match.new()
      match1.save
      match1.resume = self
      match1.job = best_job
      match1.save

      #match1.job = best_job
      #match1.save

      match2 = Match.new()
      match2.resume = self
      match2.job = best_job_2
      match2.save

  end

end
