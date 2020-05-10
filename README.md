# README
COMS 4156, Advanced Software Engineering  - Final Submission  
Bhaskar Ghosh (bg2625)  
Eugene M. Joseph (emj2152)

## WorkLede
WorkLede (pronounced Work-Lead) is platform that allows journalists to upload their resumes and receive daily email alerts for new relevent job postings.

### Running WorkLede Locally
- `bundle install`
- `rake db:migrate`
- `rails server`

### Deploying WorkLede
Run migrations on production database  
- `heroku run rake db:migrate`

Commit latest updates  
- `git add .`  
- `git commit -m 'Update Description'`  

Push latest commits to Heroku   
- `git push heroku master`

### Workers

#### Local Workers
To run workers locally, start a Sidekiq server via the `sidekiq` command in terminal. Once the Sidekiq server has started, you can send it commands via the following syntax: `rake 'workers:score_new_jobs'`. So in this case, we're calling the **score_new_jobs worker** which will be run on the Sidekiq server. Crons can be specified to run workers at the desired intervals inside the `schedule.rb` file, although we've disabled these calls as we run our workers in production via the **Heroku Scheduler** add-on.

#### Production Workers
For our production server, workers are being scheduled via the **Heroku Scheduler**. Here is an image of our current setup:
![alt text](https://worklede-12.s3.amazonaws.com/worklede_heroku.png "Heroku Scheduler Setup")


#### Job Post Scraping `rake 'workers:scrape_new_jobs'`  
This worker invokes three separate scraping scripts that pull the latest jobs from the New York Times, Washington Post, and Conde Nast into our database.  

**Important:** The websites that we scrape periodically update their HTML and thus our scraping scripts may require tweaking if they suddenly seem to stop working. But the general framework for scraping has been provided and only very minor adjustments - usually CSS class selectors - need to be updated.

#### Resume-Job Matching `rake 'workers:score_new_jobs'` 
This worker runs a script that calculates the matches for new jobs against every resume available in our database.

#### Emails `rake 'workers:send_match_emails'` 
This worker runs a script that sends users an email of the latest relavant job postings.

### Running Python Scripts
We use Python to parse our PDFs and perform NLP entity extraction and document similarity calculations to find matches between resumes and job descriptions. If running WorkLede locally, just make sure you have Python3 and the all libraries described in `requirements.txt` installed. If deploying to Heroky, make sure to install the Python Heroku Build Pack. Here is our current build pack stack for reference:
```
=== serene-inlet-00774 Buildpack URLs
1. https://github.com/heroku/heroku-buildpack-activestorage-preview
2. heroku/python
3. heroku/ruby
```



## Iteration 2 Updates
- Email delivery is live
- Site is available at www.worklede.com
- Several more user tests, in particular for testing email delivery
- Three scrapers actively pulling jobs from the New York Times, Washington Post, and Conde Nast. We're running these locally from our computers but synced to the production DB for now. Our next push on this end will be to set up a SideKiq worker/cron to periodically scrape the companies of interest.
- New Latest Jobs Listing
- New Job Matches Scoring System - Calculated via Python Spacy Document Similarity (Cosine Similarity) scoring. This happens in real-time when a user submits a new resume. Like with our scrapers, our next task will be to set up a SideKiq worker/cron to periodically score resumes against new jobs that have come in.
- New Resume Parsing Logic - Done via Python Spacy Entity Recognition



## Scrapers ()
Run scraper scripts via cron jobs with the following command:  
`rails runner app/scrapers/nyt.rb`



## Deploy
`heroku run rake db:migrate`
`git push heroku master`
