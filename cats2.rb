require 'open-uri'

kittens = open('https://www.nytimes.com')
response_status = kittens.status
response_body = kittens.read

puts response_status
puts response_body
