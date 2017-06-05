module BogoBot
  # Module for commands
  module Commands
    # Require files from directory
    Dir["#{File.dirname(__FILE__)}/commands/*.rb"].each { |file| require file }

    @commands = [
    Flip,
    Roll,
    Join,
    Leave,
    Play,
    Stop,
    Eightball,
    Define,
    Roulette
    ]

    def self.include!
      @commands.each do |command|
        BogoBot::Bot.include!(command)
      end
    end
  end

end
