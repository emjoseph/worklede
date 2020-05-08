When("I check my email after matches have been processed and there were no high matches") do
  @user.resumes.first.get_job_matches_spacey
  @user.send_email_with_new_job_matches
  sleep 5.0
end

Then("I should not see an email from Worklede with my latest job matches") do
  open_email("joseph.eugene@gmail.com")
  expect(current_email).to be nil
end
