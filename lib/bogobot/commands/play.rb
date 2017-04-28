module BogoBot
  module Commands
    
    module Play
      # Currently plays the only mp3 file in the data folder (lol)
      extend Discordrb::Commands::CommandContainer
      
      command(:play) do |event|
        # hard coded file path, initial check to see if voice works
        event.voice.play_file("./data/track1.mp3")
      end
      
      
    end
    
  end
end