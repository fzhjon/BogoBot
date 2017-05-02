module BogoBot
  module Events
    
    module Mentions
      extend Discordrb::EventContainer
      
      mention do |event|
        # The bot is directly mentioned (not @here, @everyone)
        event.message.react "✅"
        event.user.pm("sup fool")
      end
    end
    
  end
end