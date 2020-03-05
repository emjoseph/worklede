Given("that I am logged in and on my profile page and I have at least one resume") do
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
  
    @resume = user.resumes.create()
    @resume.s3_link = "https://dummy"
    @resume.name = "Bhaskar_resume"
    @resume.user_id = 1
    @resume.id = 1
    @resume.created_at = "2020-03-05 05:28:32"
    @resume.save

    page.set_rack_session(:user_id => 1)
  
    visit "/"
  end
  
  When("I click on the delete link of one of the resumes") do
    page.should have_link("Bhaskar_resume")
    click_link(@resume.id)
  
  end
  
  Then("I'll not see the deleted resume when the page refreshes") do
    visit "/"
    page.should have_no_content("Bhaskar_resume")
  end
  