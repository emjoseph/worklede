require 'HTTParty'
require 'watir'

def scrape_jobs_for_section(section_url)
  browser = Watir::Browser.new :chrome, headless: true
  browser.goto section_url
  sleep 2
  browser.scroll.to :bottom
  sleep 1

  page = Nokogiri::HTML.parse(browser.html)
  page.css('.WN0F').each do |posting|

      title = posting.css('.WI2O')[1].text
      subheader = posting.css('span.WB1F').text
      posting_code = subheader.to_s.split('|')[0].strip
      location = subheader.to_s.split('|')[1].strip
      time = subheader.to_s.split('|')[2].strip
      time_int = time.scan(/\d+/)[0].to_i
      category = browser.url.split("/").last

      # Build job link from modifications to the scraped params above
      location_mod = location.tr(',','').gsub(/[^a-z]/i, '-')
      title_mod = title.gsub(/[^a-z]/i, '-')
      job_url = "https://nytimes.wd5.myworkdayjobs.com/en-US/#{category}/job/#{location_mod}/#{title_mod}_#{posting_code}"

      # Scrape the description text from the job url
      browser.goto job_url
      sleep 2
      job_page = Nokogiri::HTML.parse(browser.html)
      job_desc = ""
      job_page.css('.GWTCKEditor-Disabled p, .GWTCKEditor-Disabled li').each do |desc|
          if desc.text.length > 6
              firstWords = desc.text.split[0...6].join(" ")
              if firstWords == "The New York Times is committed"
                  break
              end
              job_desc += desc.text + " "
          end
      end
      job_desc = job_desc.strip()

      # Initialize new Job ActiveRecord
      job = Job.new()
      job.url = job_url
      job.desc = job_desc
      job.title = title
      job.code = posting_code
      job.company = "The Washington Post"
      job.platform = "Workday"
      job.posted_days_ago_string = time
      job.posted_days_ago_int = time_int
      job.category = category

      # Save Job if not already in database
      if Job.where(:code => job.code, :company => job.company).blank?
        puts "Job doesn't exist. Save to DB."
        job.save
      else
        puts "This job is already in our DB."
      end

  end
end

jobs_section_urls = [
  "https://washpost.wd5.myworkdayjobs.com/washingtonpostcareers/jobs"
]

jobs_section_urls.each { |section_url|
   section = section_url.split("/").last
   puts "Scraping jobs for #{section}"
   scrape_jobs_for_section(section_url)
}
