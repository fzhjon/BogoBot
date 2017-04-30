module BogoBot
  module Commands
  
    module Eightball
  
      # Gives you your fortune
      extend Discordrb::Commands::CommandContainer
      
      command(:eightball,
              min_args:1,
              usage:"find your fortune.",
              description: "find your fortune.") do |event, *query|
		
        #Statically declared array cause fuk
        fortunes = [
        "it is certain", 
        "it is decidedly so", 
        "without a doubt", 
        "yes definitely", 
        "you may rely on it", 
        "as i see it, yes", 
        "most likely", 
        "outlook good", 
        "yes", 
        "signs point to yes", 
        "reply hazy try again", 
        "ask again later", 
        "better not tell you now", 
        "cannot predict now", 
        "concentrate and ask again", 
        "don't count on it", 
        "my reply is no", 
        "my sources say no", 
        "outlook not so good", 
        "very doubtful"]
        
        event.send_message(fortunes[rand(0..19)])	
      end
      
    end
    
  end
end