module BogoBot
  module Commands
    
    module Leave
      extend Discordrb::Commands::CommandContainer
      
      command(:leave) do |event|
        event.voice.destroy
        nil
      end
      
      
    end
    
  end
end