#exit
require 'watir'
require 'json'

def scrape_jobs_for_section(url, section_name, company, platform, browser)

  headers = {
    "Accept"  => "application/json,application/xml"
  }

  jsonResponse = HTTParty.get(
    url,
    :headers => headers
  )

  itemUrls = []

  linkJson = JSON.parse(jsonResponse.body)
  linkItems =  linkJson['body']['children'][0]['children'][0]['listItems']
  linkItems.each { |item|
      itemUrls.append(item['title']['commandLink'])
  }

  browser.goto url
  sleep 2

  #NOTE: Workday will often change the posting selecctor and the title and subheader selectors

  page = Nokogiri::HTML.parse(browser.html)
  page.css('.WC1F').each_with_index do |posting, index|
      title = posting.css('.WM2O')[1].text
      subheader = posting.css('span.WE1F').text

      posting_code = subheader.to_s.split('|')[0].strip
      location = subheader.to_s.split('|')[1].strip
      time = subheader.to_s.split('|')[2].strip
      time_int = time.scan(/\d+/)[0].to_i

      # Build job link from modifications to the scraped params above
      location_mod = location.tr(',','').gsub(/[^a-z]/i, '-')
      title_mod = title.gsub(/[^a-z]/i, '-')
      job_url = "https://nytimes.wd5.myworkdayjobs.com#{itemUrls[index]}"

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
      job.company = company
      job.platform = platform
      job.posted_days_ago_string = time
      job.posted_days_ago_int = time_int
      job.category = section_name
      job.location = location

      # Save Job if not already in database
      if Job.where(:code => job.code, :company => job.company).blank?
        puts "Job doesn't exist. Save to DB."
        job.save
      else
        puts "This job is already in our DB."
      end
  end
end

browser = Watir::Browser.new :chrome, headless: true

jobs_section_urls = [
  ["https://nytimes.wd5.myworkdayjobs.com/Marketing", "Marketing", "The New York Times", "Workday"],
  ["https://nytimes.wd5.myworkdayjobs.com/Tech", "Tech", "The New York Times", "Workday"],
  ["https://nytimes.wd5.myworkdayjobs.com/News", "News", "The New York Times", "Workday"],
  ["https://nytimes.wd5.myworkdayjobs.com/DataInsights", "Data Insights", "The New York Times", "Workday"]
]

jobs_section_urls.each { |section_array|
   url = section_array[0]
   section_name = section_array[1]
   company = section_array[2]
   platform = section_array[3]

   puts "Scraping jobs for #{section_name}"
   scrape_jobs_for_section(url, section_name, company, platform, browser)
   puts "----------------------------"
}
