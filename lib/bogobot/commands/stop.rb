module BogoBot
  module Commands
    
    module Stop
    
      extend Discordrb::Commands::CommandContainer
      command(:stop,
              usage:"`stop while the bot is playing audio.",
              description: 'Stops audio from playing.') do |event|
            event.voice.stop_playing if event.voice.playing?
      end
      
      
    end
    
  end
end