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

Note: Right now we've set up our database.yml file so that our development database actually connects to our production PostgresSQL database on Heroku. If you're a TA grading this, make sure to run the app from the zipped file directory we've attached. This GitHub repo does not contain the `env.yml` file that contains the keys required to connect to our Heroku database, AWS services, LinkedIn LogIn app, and MailGun email delivery endpoint.

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

**Important:** We're using the Watir gem that requires a Chrome driver to scrape websites. The Chrome driver can be installed here: http://watir.com/guides/drivers/. This should work fine locally once the Chromed driver is installed. When running on Heroku, make sure to add the required buildpacks which can be accessed here: https://github.com/heroku/heroku-buildpack-chromedriver

#### Resume-Job Matching `rake 'workers:score_new_jobs'` 
This worker runs a script that calculates the matches for new jobs against every resume available in our database.

#### Emails `rake 'workers:send_match_emails'` 
This worker runs a script that sends users an email of the latest relavant job postings.

### Running Python Scripts
We use Python to parse our PDFs and perform NLP entity extraction and document similarity calculations to find matches between resumes and job descriptions. If running WorkLede locally, just make sure you have Python3 and the all libraries described in `requirements.txt` installed. If deploying to Heroku, make sure to add the Python Heroku Build Pack as well as the other buildpacks listed below. Here is our current build pack stack for reference:
```
=== serene-inlet-00774 Buildpack URLs
1. https://github.com/heroku/heroku-buildpack-activestorage-preview
2. heroku/python
3. heroku/ruby
4. https://github.com/heroku/heroku-buildpack-chromedriver
5. https://github.com/heroku/heroku-buildpack-google-chrome
6. https://github.com/heroku/heroku-buildpack-xvfb-google-chrome
```
