module BogoBot
  module Events
    
    module Replies
      extend Discordrb::EventContainer
      
      message(content: /damn/i) do |event|
        event.respond "daniel"
      end
      
      message(content: /tim/i) do |event|
        event.respond "turtle"
      end
      
    end
    
  end
end