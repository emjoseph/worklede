When("I visit the home page to see the latest jobs") do
  job1 = Job.new
  job1.title = "Engineer"
  job1.posted_days_ago_int = 0
  job1.posted_days_ago_string = "Today"
  job1.desc = "New"
  job1.location = "NYC"
  job1.url = "http://www.worklede.com"
  job1.company = "Worklede"
  job1.save

  job2 = Job.new
  job2.title = "Engineer"
  job2.posted_days_ago_int = 0
  job2.posted_days_ago_string = "Today"
  job2.desc = "New"
  job2.location = "NYC"
  job2.url = "http://www.worklede.com"
  job2.company = "Worklede"
  job2.save

  job3 = Job.new
  job3.title = "Engineer"
  job3.posted_days_ago_int = 0
  job3.posted_days_ago_string = "Today"
  job3.desc = "New"
  job3.location = "NYC"
  job3.url = "http://www.worklede.com"
  job3.company = "Worklede"
  job3.save

  job4 = Job.new
  job4.title = "Engineer"
  job4.posted_days_ago_int = 0
  job4.posted_days_ago_string = "Today"
  job4.desc = "New"
  job4.location = "NYC"
  job4.url = "http://www.worklede.com"
  job4.company = "Worklede"
  job4.save

  job5 = Job.new
  job5.title = "Engineer"
  job5.posted_days_ago_int = 0
  job5.posted_days_ago_string = "Today"
  job5.desc = "New"
  job5.location = "NYC"
  job5.url = "http://www.worklede.com"
  job5.company = "Worklede"
  job5.save

  job6 = Job.new
  job6.title = "Old"
  job6.posted_days_ago_int = 2
  job6.posted_days_ago_string = "2 days ago"
  job6.desc = "Old"
  job6.location = "NYC"
  job6.url = "http://www.worklede.com"
  job6.company = "Worklede"
  job6.save

  visit "/"
end

Then("I see a section with the latest jobs and it only contains the latest five jobs posted") do
  page.should have_no_content("Old")
end
