require 'twilio-ruby'
require 'rufus-scheduler'
require 'httparty'

# Set up a client to talk to the Twilio REST API.
account_sid = ENV["TWILIO_ACCOUNT_SID"] # Your Account SID from www.twilio.com/console
auth_token = ENV["TWILIO_AUTH_TOKEN"] # Your Auth Token from www.twilio.com/console
@client = Twilio::REST::Client.new account_sid, auth_token
