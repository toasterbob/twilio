require 'twilio-ruby'
require 'rufus-scheduler'
require 'httparty'
require 'json'
require 'open-uri'
require 'sinatra'

# Set up a client to talk to the Twilio REST API.
account_sid = ENV["TWILIO_ACCOUNT_SID"]
auth_token = ENV["TWILIO_AUTH_TOKEN"]
@client = Twilio::REST::Client.new account_sid, auth_token

def get_advice
  r = open('http://api.adviceslip.com/advice')

  if r.status[0] == "200"
    doc = ""

    r.each do |line|
      doc << line
    end

    doc = JSON.parse(doc, :symbolize_names => true)
    advice = doc[:slip][:advice]

    return advice
  end

end

def send_MMS

  body = "Your daily advice: #{get_advice}"

  begin
    @client.messages.create(
      body: body,
      # media_url: media,
      to: '+19542782210',
      from: '+12534263667'
    )
    puts "Message sent!"
  rescue Twilio::REST::RequestError => e
    puts e.message
  end

end



scheduler = Rufus::Scheduler.new

scheduler.every '1m' do
  send_MMS
end
scheduler.join
