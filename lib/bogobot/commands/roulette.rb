module BogoBot
  module Commands

    module Roulette

      # Bet some points to see what you win
      extend Discordrb::Commands::CommandContainer

      command(:roulette,
              min_args:1,
              usage:"roulette <points>, where points your bet",
              description: "Bet points for big gains!") do |event, bet|

        client = Mongo::Client.new(ENV['POINTSDB'])
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
        doc = points.find(name: player.id)
        new_total = doc["points"].to_i - result
        # Gamble calculations
        chance = rand(0..10)
        case chance
        when chance <= 4
          result = 0
          event.send_message("Wow! You lost your bet!")
        when chance == 9 || chance == 8
          result = 1.5 * result
          event.send_message("Not bad... Ok gains!")
        when chance == 10
          result = 3 * result
          event.send_message("BIG GAINS! 100% return on investment! Great Value!")
        else
          event.send_message("Hmm, no gains...")
        end
        new_total = new_total + result
        event.send_message("New Point Total: #{ new_total }")

        # Update database
        points.update_one({ 'name' => player.id }, { '$set'=> { 'points' => new_total } } )

      end

    end

  end
end
