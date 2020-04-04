# README

Software Engineering - Iteration 1
Bhaskar Ghosh (bg2625)
Eugene M. Joseph (emj2152)

## Iteration 2 Updates
- Email delivery is live
- Site is available at www.worklede.com
- Several more user tests, in particular for testing email delivery
- Three scrapers active pulling jobs from the New York Times, Washington Post, and Conde Nast
- New Latest Jobs Listing
- New Job Matches - Calculated via Python Spacy Document Similarity (Cosine Similarity) scoring
- New Resume Parsing Logic - Done via Python Spacy Entity Recognition



## Scrapers
Run scraper scripts via cron jobs with the following command:  
`rails runner app/scrapers/nyt.rb`



## Deploy
`heroku run rake db:migrate`
`git push heroku master`
