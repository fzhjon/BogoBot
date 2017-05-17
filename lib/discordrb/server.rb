module Discordrb
  class Server
    attr_reader :player
    
    old_initialize = instance_method(:initialize)
    define_method(:initialize) do |data, bot, exists = true|
      old_initialize.bind(self).call(data, bot, exists)
      @player = BogoBot::VideoPlayer.new()
    end
    
  end
end