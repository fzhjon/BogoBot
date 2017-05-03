module BogoBot
  module Commands
    
    module Play
    
      extend Discordrb::Commands::CommandContainer
      
      command([:play, :y, :p],
              min_args:1,
              usage:"'play/y/p query', where query is a url or youtube query. Attempts to play the relevant audio.",
              description: 'Plays a given audio source.') do |event, *query|
        # Run query through youtube-dl first
        options = {
                    default_search: 'auto',
                    playlist_end: 10, 
                    format: 'bestaudio/best'
                  }
        fixed_query = query.join(' ')
        results = YoutubeDL::Video.new(fixed_query, options).information
        
        # TODO: error checking in case the youtube-dl call fails
        
        # Find direct audio url and other data from results
        url = results[:url]
        title = results[:title]
        uploader = results[:uploader]
        
        # Show found audio
        event.send_message("%s - %s" % [title, uploader])
        # Library function to play found audio url
        event.voice.play_file(url)
      end
      
      
    end
    
  end
end