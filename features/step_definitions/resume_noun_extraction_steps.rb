Given("that a pdf resume is uploaded to Worklede") do

  @fileUploadPath = "#{Rails.root}/features/files/resume.pdf"
  @testFileUploadPath = "#{Rails.root}/features/files/test_resume.pdf"
  FileUtils.cp(@fileUploadPath, @testFileUploadPath)

end

When("the system has finished parsing the resume") do
  @json_str = `python3 nlp/resume_parser.py "#{@testFileUploadPath}"`
end

Then("all the nouns will be properly extracted") do
  puts @json_str
  resume_json = JSON.parse(@json_str)
  resume_nouns = resume_json['nouns']

  expect(resume_nouns).to include("multimedia")

end
