require 'twilio-ruby'
require 'rufus-scheduler'
require 'httparty'


# Set up a client to talk to the Twilio REST API.
account_sid = ENV["TWILIO_ACCOUNT_SID"] # Your Account SID from www.twilio.com/console
auth_token = ENV["TWILIO_AUTH_TOKEN"] # Your Auth Token from www.twilio.com/console
@client = Twilio::REST::Client.new account_sid, auth_token

def get_quote
  r = HTTParty.get('https://morbotron.com/api/random')
  #check if our request had a valid response_body

  if r.code == 200
    json = r.parsed_response
    #Extract the ep number and time stamp from API response.
    _____, episode, timestamp = json["Frame"].values

    #build a proper URL
    image_url = "https://morbotron.com/meme" + episode + "/" + timestamp.to_s

    # Combine each line of subtitles into one string, seperated by newlines.
    caption = json["Subtitles"].map{|subtitle| subtitle["Content"]}.join("\n")

    return image_url, caption
  end
end

def send_MMS
  media, body = get_quote
  body += media 
  begin
    @client.messages.create(
      body: body + media,
      # media_url: media,
      to: '+19542782210',
      from: '+12534263667'
    )
    puts "Message sent!"
  rescue Twilio::Rest::RequestError => e
    puts e.message
  end

end



send_MMS
