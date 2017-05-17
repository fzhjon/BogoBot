module BogoBot
 
  class VideoPlayer
  
    # Whether something is being played
    attr_accessor :playing
    
    # Whether the current video is being looped
    attr_accessor :loop
    
    # Queue of the songs
    attr_accessor :queue
    
    def initialize()
      @queue = []
      @loop = false
      @playing = false
    end
    
    def add_video(query)
      video = Video.new(query)
      @queue << video
    end
   
  end
end