Given("that I am on the home page") do
  visit '/'
end

When("I click on the Log In link") do
  click_link("log_in")
end

Then("I am redirected to LinkedIn") do
  expect(current_page).to have_current_path('https://www.linkedin.com/uas/login', url: true)
end
