class ResumeMatchWorker
  include Sidekiq::Worker
  def getMatchesForResume(resume)
      resume.get_job_matches_spacey
  end
end
