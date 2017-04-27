require 'discordrb'
require 'yaml'
require_relative 'events'
require_relative 'events/replies'
require_relative 'commands'
require_relative 'commands/flip'
require_relative 'commands/roll'

module BogoBot
  Config = YAML.load_file('../data/config.yaml')
  Bot = Discordrb::Commands::CommandBot.new token: Config['token'],
                                             client_id: Config['client_id'], 
                                             prefix: '`'
  Events.include!
  Commands.include!
  
  Bot.run
end