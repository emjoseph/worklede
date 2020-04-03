
require 'json'

headers = {
  "Accept"  => "application/json,application/xml"
}

jsonResponse = HTTParty.get(
  "https://nytimes.wd5.myworkdayjobs.com/News",
  :headers => headers
)

itemUrls = []

linkJson = JSON.parse(jsonResponse.body)
linkItems =  linkJson['body']['children'][0]['children'][0]['listItems']
linkItems.each { |item|
    itemUrls.append(item['title']['commandLink'])
}

puts(itemUrls)
