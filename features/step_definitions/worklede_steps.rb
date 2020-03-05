Given(/^I am on the home page$/) do
    visit root_path
end

When(/^I click on Sign upn button$/) do
    click_button("Sign Up")
end

Then /^I should be redirected to the (.+?) page$/ do |page_name|
    Then "I should be on the #{page_name} page"
  end