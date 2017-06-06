module BogoBot
  module Commands

    module Roulette

      # Bet some points to see what you win
      extend Discordrb::Commands::CommandContainer

      command(:roulette,
              min_args:1,
              usage:"roulette <points>, where points is your bet",
              description: "Bet points for big gains!") do |event, bet|

        client = Mongo::Client.new(Config['POINTSDB'])
        points = client[:points]
        player = event.user

        # Give first time users some free points
        if points.count(name: player.id) == 0
          event.send_message("You've never played before so here's 10000 points!")
          doc = { name: player.id, points: 10000 }
          points.insert_one(doc)
        end

        # Take the points the user is betting
        result = bet.to_i
        # Get the user's current point balance
        doc = points.find(name: player.id).first
        new_total = doc["points"].to_i

        # Make sure users have enough funds.
        if new_total < result
          event.send_message("Nice try, but you're too much of a pleb for that bet...")
        else
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
            event.send_message("100% return on investment! Great Value!")
          elsif chance <= 99
            result = 3 * result
            event.send_message("BIG GAINS! 💰🤑💰")
          elsif chance == 100
            result = 10 * result
            event.send_message("💵💵💵💵💸💸💸💰💰🤑💰💰💸💸💸💵💵💵💵")
            event.send_message("You rich boi!!!")
          end

          # Calculate new balance
          new_total = new_total + result
          # Update database and output new ba;ance
          points.update_one({ 'name' => player.id }, { '$set'=> { 'points' => new_total } } )
          event.send_message("New Point Total: #{ new_total }")
        end

      end

    end

  end
end
