module BogoBot
  module Commands
    
    module Roll
      extend Discordrb::Commands::CommandContainer
      
      command(:roll,
              min_args:1,
              max_args:1,
              usage:"'roll n', where n is an integer > 0. Randomly produces a number between 1 to n.",
              description: 'Rolls an n-sided die once.') do |event, num|
        n = num.to_i
        if n <= 0
          "hey how about you actually use a valid number you neanderthal"
        else
          rand(1..n)
        end
      end
      
      
    end
    
  end
end