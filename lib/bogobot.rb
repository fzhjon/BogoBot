require 'discordrb'
require 'yaml'
require 'youtube-dl.rb'
require 'json'
require 'mongo'
Dir["#{File.dirname(__FILE__)}/bogobot/*.rb"].each { |file| require file }
Dir["#{File.dirname(__FILE__)}/discordrb/*.rb"].each { |file| require file }

module BogoBot
  Config = YAML.load_file('data/config.yaml')
  Bot = Discordrb::Commands::CommandBot.new token: Config['token'],
                                             client_id: Config['client_id'],
                                             prefix: '`'


  Events.include!
  Commands.include!

  Bot.run(:async)
  loop do
    sleep(10)
  end
end
