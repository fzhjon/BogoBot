module BogoBot
  module Commands
    
    module Join
      extend Discordrb::Commands::CommandContainer
      
      command(:join) do |event|
        channel = event.user.voice_channel
        event.bot.voice_connect(channel)
        nil
      end
      
    end
    
  end
end