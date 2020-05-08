Given("that I have created an account and have upload a resume") do
  @user = User.new
  @user.provider = "linkedin"
  @user.id = 1
  @user.uid = "wEkqlJ6dw5"
  @user.image_url = "https://media-exp1.licdn.com/dms/image/C5603AQHLM-DOKd4Xew/profile-displayphoto-shrink_800_800/0?e=1588809600&v=beta&t=Wr-e2Scx3MCbGrtQgt2BRKhzIcK2cz64PwQoMyj5oLA"
  @user.access_token = "AQVnsRejb5O8aounoaA69xcVkQn4L5_41mnFKlrsRz9Li4arks4wPshjaPG_z4hy5OelLF_CMeCO2nLr_F7nNN_StQvpHmbfEgKysCPfyX18LnviAU__N3q3r2htOmTXZL3RE_-v9syzWIl5m9VK2agWmZ4h9mykoWynEriXPqJHiUTp-F1P9xSwlbu3Omsl25VCrGRR9VxEffwNZsuqeAFkRKs6yMto9Gbm1a8HSKr3GdiD-67OML_uE0q0MZ-so-nR3GcTsZIkiOOn0gzyl1rM8P9itEBfbtaTIt22eg_UxZUl2oI0tXP_YK0c9sthmrJGzXAjXqRX2_LkMArClgMAG96w6Q"
  @user.first_name = "Eugene"
  @user.last_name = "Joseph"
  @user.email = "joseph.eugene@gmail.com"
  @user.created_at = "2020-03-05 04:28:32"
  @user.save

  resume = @user.resumes.create()
  ## Assuming this resume: Enthusiastic software engineer with 4+ years experience participating in the complete product development lifecycle of successfully launched applications. Eager to join XYZ Inc. to deliver mission-critical technology and business solutions to Fortune 500 companies and some of the most recognized brands on the planet. In previous roles, reduced downtime by 15% and warranty costs by 25%; identified and resolved a process bottleneck that reduced coding efficiency by up to 30%.
  # Here we're filling in the nouns that would have been extracted from a resume
  resume_text = '{"nouns": ["software", "engineer", "experience", "product", "development", "lifecycle", "applications", "news", "organization", "mission", "critical", "technology", "business", "solutions", "roles", "bottleneck", "coding", "efficiency", "tech", "software"]}'
  resume.resume_txt = resume_text
  resume.save

  job1 = Job.new
  job1.title = "Engineer"
  job1.posted_days_ago_int = 0
  job1.desc = "Arc Publishing is a product engineering group at The Washington
  Post. We build software to meet the needs of The Post, while also making
  the same software available to other publishers around the world via
  software as a service. The Arc suite of products provides publishers with
  the tools they need to author, manage and publish content to meet the
  ever-changing demands of news readers. Arc is quickly becoming the leader
  in publishing-focused software development. Built 100% on AWS, the Arc
  platform follows a microservice architecture. All of our software teams use
  devops to deliver and maintain products. Our processes are lightweight,
  which allows our teams to innovate quickly to bring new ideas to market.
  New features and products are deployed to our customer base every day.
  We are currently looking for a Full Stack Software Engineer to help us
  build and maintain several key web-based applications to expand our
  capabilities on the Arc Platform. Our newsroom apps create an engaging
  experience that allows for productivity and speed of publishing."
  job1.save

  job2 = Job.new
  job2.title = "Reporter"
  job2.posted_days_ago_int = 0
  job2.desc = "This rapid-response reporter will be expected to write breaking
  travel news and quickly spot industry trends, suitable for smart takes and
  comprehensive analysis. Candidates should be comfortable producing a high
  volume of stories on daily deadlines. The ideal candidate possesses sharp
  storytelling skills and has demonstrated a talent for taking advantage of
  digital opportunities and social tools. We are looking for someone who is
  creative, writes in a conversational style and delivers sharp headlines.
  Experience in travel, transportation or business reporting is preferred.
  SEO experience and a strong social media presence are a plus. This role will
  not involve travel."
  job2.save
end

When("I check my email") do
  @user.resumes.first.get_job_matches_spacey
  @user.send_email_with_new_job_matches_test
  sleep 5.0
end

Then("I should see an email from Worklede with my latest job matches") do
  open_email("joseph.eugene@gmail.com")
  puts current_email
  puts "----------------"
  puts current_email.subject
  expect(current_email.subject).to eq "WorkLede: Latest Job Matches"
end
