module BogoBot
  module Commands
    
    module Flip
      extend Discordrb::Commands::CommandContainer
      
      command(:flip, description: 'Flips a coin.') do 
        ["Heads", "Tails"].sample
      end
      
      
    end
    
  end
end