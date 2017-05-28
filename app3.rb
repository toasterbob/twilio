require 'rubygems'
require 'sinatra'

get '/hello' do
  response =<<EOF
<Response>
  <Say>Hello from moocode</Say>
</Response>
EOF
end
