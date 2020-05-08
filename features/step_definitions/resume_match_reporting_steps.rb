Given("that my resume with reporting focused experience has been parsed and is ready to be matched") do

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
  ## Assuming this resume: Researched article topics and met and interviewed
  ## multiple sources to be included with news story. Requested and obtained
  ## public records to validate information for articles. Conducted and uploaded
  ## video recorded interviews with news sources. Published six to eight new
  ## stories and feature articles a week on deadline. Proficient storytelling, social
  ## media, and business reporting professional. I'm also great at analyzing trends.

  # Here we're filling in the nouns that would have been extracted from a resume
  resume_text = '{"nouns": ["article", "topics", "sources", "news", "story", "records", "interviews", "sources", "six", "eight", "stories", "articles", "deadlines", "storytelling", "media", "professional", "trends"]}'
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

When("the matching algorithm process is complete") do
  @user.resumes.first.get_job_matches_spacey
end

Then("the top job match will be for a reporting job") do
  matches = @user.get_new_matches_score_agnostic_for_testing
  match_engineering_job = nil
  match_reporting_job = nil
  matches.each { |match|
      if match.job.title == 'Reporter'
        match_reporting_job = match
      end

      if match.job.title == 'Engineer'
        match_engineering_job = match
      end
  }
  expect(match_reporting_job.score).to be > match_engineering_job.score
end
