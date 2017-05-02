module BogoBot
  # Module for (mostly) chat events
  module Events
    # Require files from directory
    Dir["#{File.dirname(__FILE__)}/events/*.rb"].each { |file| require file }
  
    @events = [
    Replies,
    Reacts,
    Mentions
    ]
    
    def self.include!
      @events.each do |event|
        BogoBot::Bot.include!(event)
      end
    end
  end
  
end