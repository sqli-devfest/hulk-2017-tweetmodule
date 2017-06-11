#! /usr/bin ruby
#Connect to the 'results' mqtt topic on the mqtt hostname, read the json messages and tweet them
#Twitter credentials must be provided as environment variables

require "mqtt"
require "twitter"
require 'json'

#twitter config
@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['twitter_consumer_key']
  config.consumer_secret     = ENV['twitter_consumer_secret']
  config.access_token        = ENV['twitter_access_token']
  config.access_token_secret = ENV['twitter_access_token_secret']
end


#tweet the result message
def tweet(message_hash)
  tweet_string="#{message_hash['player']['firstName']} #{message_hash['player']['lastName']} a fait un score de #{message_hash['game']['score']}"
  puts tweet_string
  @client.update(tweet_string)
end

#connect to the mqtt 'results topic' parse the result json messages and tweet them
MQTT::Client.connect('mqtt') do |c|
  c.get('results') do |topic,json_message|
    begin
      puts "#{topic}: #{json_message}"
      message_hash = JSON.parse(json_message)
      tweet message_hash
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end
end
