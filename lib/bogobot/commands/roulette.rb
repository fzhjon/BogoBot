module BogoBot
  module Commands

    module Roulette

      # Bet some points to see what you win
      extend Discordrb::Commands::CommandContainer

      command(:roulette,
              min_args:1,
              usage:"roulette <points>, where points is your bet",
              description: "Bet points for big gains!") do |event, bet|

        client = Mongo::Client.new('mongodb://127.0.0.1:27017/roulettedb')
        points = client[:points]
        player = event.user

        # Give first time users some free points
        if points.count(name: player.id) == 0
          event.send_message("You've never played before so here's 1000 points!")
          doc = { name: player.id, points: 1000 }
          points.insert_one(doc)
        end

        # Take the points they're betting
        result = bet.to_i
        doc = points.find(name: player.id).first
        new_total = doc["points"].to_i - result
        # Gamble calculations
        chance = rand(101)
        if chance <= 40
          result = 0
          event.send_message("Wow! You lost your bet!")
        elsif chance <= 65
          event.send_message("Hmm, no gains...")
        elsif chance <= 85
          result = (1.5 * result).to_i
          event.send_message("Not bad... Ok gains!")
        elsif chance <= 95
          result = 2 * result
          event.send_message("BIG GAINS! 100% return on investment! Great Value!")
        elsif chance <= 99
          result = 10 * result
          event.send_message("💵💵💵💵💸💸💸💰💰🤑💰💰💸💸💸💵💵💵💵")
          event.send_message("You rich boi!!!")
        elsif chance == 100
        end

        new_total = new_total + result
        # Update database
        points.update_one({ 'name' => player.id }, { '$set'=> { 'points' => new_total } } )
        event.send_message("New Point Total: #{ new_total }")

      end

    end

  end
end
