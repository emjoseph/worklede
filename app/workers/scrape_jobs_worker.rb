class ScrapeJobsWorker
  include Sidekiq::Worker
  def perform()
    eval File.read("app/scrapers/nyt.rb")
    sleep 60
    eval File.read("app/scrapers/wapo.rb")
    sleep 60
    eval File.read("app/scrapers/condenast.rb")
  end
end
