module BogoBot
  module Commands
    
    module Play
    
      extend Discordrb::Commands::CommandContainer
      
      command([:play, :y, :p],
              min_args:1,
              usage:"'play/y/p query', where query is a url or youtube query. Attempts to play the relevant audio.",
              description: 'Plays a given audio source.') do |event, *query|
                  
        fixed_query = query.join(' ')
        
        player = event.server.player
        player.add_video(fixed_query)
        
        unless player.playing
          player.playing = true
          loop do
            break if player.queue.empty?
            video = player.queue.shift
            event.send_message("%s - %s" % [video.title, video.uploader])
            event.voice.play_file(video.path)
          end
          player.playing = false
        end
        
        nil
        
      end
      
    end
    
  end
end