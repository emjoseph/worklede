exit

require 'watir'

browser = Watir::Browser.new :chrome, headless: true
url = "https://nytimes.wd5.myworkdayjobs.com/en-US/News/job/New-York-NY/Manager--International-SEO_REQ-004492"

browser.goto url
sleep 2

page = Nokogiri::HTML.parse(browser.html)
html_text = page.css('#richTextArea\.jobPosting\.jobDescription-input--uid6-input .GWTCKEditor-Disabled').text
html_text.slice!("Job Description")
html_text = html_text.gsub("*",".")
desc = ""
html_text.split(".").each{ |sentence|
  desc += sentence.strip + ". "
}

puts desc
