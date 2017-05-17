module BogoBot
  # class containing a single video, each instance is an object containing a video according to intialization url
  class Video
    attr_reader :title, :url, :length, :path, :uploader
    
    def initialize(query)
      dl_options = {
                    default_search: 'auto',
                    playlist_end: 10, 
                    format: 'bestaudio/best'
                  }
      # hard code path (for now? maybe forever)
      # random filename
      dl_options[:output] = "data/#{('a'..'z').to_a.shuffle[0,8].join}.mp3"
      
      @youtube_dl = YoutubeDL::Video.new(query, dl_options)
      @youtube_dl.download
      
      @title = @youtube_dl.title
      @url = "https://youtu.be/#{@youtube_dl.url}"
      @path = @youtube_dl.filename
      # length is in seconds, needs formatting
      @length = @youtube_dl.duration
      @uploader = @youtube_dl.uploader
      
    end
    
  end
end