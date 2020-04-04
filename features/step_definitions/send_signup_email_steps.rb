Given("that I have signed in using LinkedIn for the first time") do
  user = User.new
  user.provider = "linkedin"
  user.id = 1
  user.uid = "wEkqlJ6dw5"
  user.image_url = "https://media-exp1.licdn.com/dms/image/C5603AQHLM-DOKd4Xew/profile-displayphoto-shrink_800_800/0?e=1588809600&v=beta&t=Wr-e2Scx3MCbGrtQgt2BRKhzIcK2cz64PwQoMyj5oLA"
  user.access_token = "AQVnsRejb5O8aounoaA69xcVkQn4L5_41mnFKlrsRz9Li4arks4wPshjaPG_z4hy5OelLF_CMeCO2nLr_F7nNN_StQvpHmbfEgKysCPfyX18LnviAU__N3q3r2htOmTXZL3RE_-v9syzWIl5m9VK2agWmZ4h9mykoWynEriXPqJHiUTp-F1P9xSwlbu3Omsl25VCrGRR9VxEffwNZsuqeAFkRKs6yMto9Gbm1a8HSKr3GdiD-67OML_uE0q0MZ-so-nR3GcTsZIkiOOn0gzyl1rM8P9itEBfbtaTIt22eg_UxZUl2oI0tXP_YK0c9sthmrJGzXAjXqRX2_LkMArClgMAG96w6Q"
  user.first_name = "Eugene"
  user.last_name = "Joseph"
  user.email = "joseph.eugene@gmail.com"
  user.created_at = "2020-03-05 04:28:32"
  user.save
  page.set_rack_session(:user_id => 1)
  visit "/"
end

When("I successfully login") do
  user = User.find(1)
  # Note: This is only called when a user succesfully logs in for the first time...
  user.send_welcome_email

end

Then("I will receive an email saying that I have signed up for WorkLede") do
  open_email("joseph.eugene@gmail.com")
  puts current_email
  puts current_email.subject
  expect(current_email.subject).to eq "Welcome to WorkLede!"
end
