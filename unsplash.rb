require 'open-uri'

kittens = open('https://unsplash.it/200/300')

f = File.open('unsplash.jpg', 'w')
kittens.each do |kitten|
  f.write(kitten)
end

f.close
