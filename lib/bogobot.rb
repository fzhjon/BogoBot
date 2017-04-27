require 'discordrb'
require 'yaml'
require_relative 'events'
require_relative 'events/replies'

module BogoBot
  Config = YAML.load_file('../data/config.yaml')
  Bot = Discordrb::Commands::CommandBot.new token: Config['token'],
                                             client_id: Config['client_id'], 
                                             prefix: '`'
  Events.include!
  
  Bot.run
end