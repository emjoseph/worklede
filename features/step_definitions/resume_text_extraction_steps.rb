Then("all the text will be properly extracted") do
  puts @json_str
  resume_json = JSON.parse(@json_str)
  resume_text = resume_json['text']

  expect(resume_text.split(" ")).to include("multimedia")

end
