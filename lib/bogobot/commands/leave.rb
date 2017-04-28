module BogoBot
  module Commands
    
    module Leave
      extend Discordrb::Commands::CommandContainer
      
      command(:leave) do |event|
        event.bot.voice_destroy(event.server)
      end
      
      
    end
    
  end
end