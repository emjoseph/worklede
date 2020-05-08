When("I visit the home page") do
  visit "/"
end

Then("I see a section with the latest jobs") do
  page.should have_content("Latest Jobs")
end
