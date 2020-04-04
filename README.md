# README

Software Engineering - Iteration 1
Bhaskar Ghosh (bg2625)
Eugene M. Joseph (emj2152)

## Iteration 2 Updates
- Email delivery is live
- Site is available at www.worklede.com
- Several more user tests, in particular for testing email delivery
- Three scrapers actively pulling jobs from the New York Times, Washington Post, and Conde Nast. We're running these locally from our computers but synced to the production DB for now. Our next push on this end will be to set up a SideKiq worker/cron to periodically scrape the companies of interest.
- New Latest Jobs Listing
- New Job Matches Scoring System - Calculated via Python Spacy Document Similarity (Cosine Similarity) scoring. This happens in real-time when a user submits a new resume. Like with our scrapers, our next task will be to set up a SideKiq worker/cron to periodically score resumes against new jobs that have come in.
- New Resume Parsing Logic - Done via Python Spacy Entity Recognition



## Scrapers
Run scraper scripts via cron jobs with the following command:  
`rails runner app/scrapers/nyt.rb`



## Deploy
`heroku run rake db:migrate`
`git push heroku master`
