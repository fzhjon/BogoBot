module BogoBot
  module Commands
    
    module Define
      extend Discordrb::Commands::CommandContainer
      
      command(:define,
              min_args:1,
              max_args:1,
              usage:"'define word', where word is a word lol! Attempts to find a definition for the word.",
              description:"Defines a given word.") do |event, word|
        # Make a request
        uri = URI('http://api.pearson.com/v2/dictionaries/ldoce5/entries')
        params = { headword: word, limit: 1 }
        uri.query = URI.encode_www_form(params)
        resp = Net::HTTP.get_response(uri)
        if resp.is_a?(Net::HTTPSuccess)
          # Check body
          body = JSON.parse(resp.body)
          if body['total'] == 0
            # Ending execution
            event.send_message("No results for %s" % [word])
            return
          end
          # Extracting relevant info
          result = body['results'][0]
          info = Hash.new("not found")
          
          info[:word] = result['headword']
          info[:type] = result['part_of_speech']
          # Any better ideas for error catching?
          if result['pronunciations'] != nil
            info[:ipa] = result['pronunciations'][0]['ipa']
          end
          if result['senses'][0]['definition'] != nil
            info[:definition] = result['senses'][0]['definition'][0]
          end
          if result['senses'][0]['examples'] != nil
            info[:example] = "\"#{result['senses'][0]['examples'][0]['text']}\""
          end
          
          # **word** [ipa]: *type*. definition. example
          event.send_message("**#{info[:word]}** [#{info[:ipa]}]: "\
                             "*#{info[:type]}*. #{info[:definition]}. "\
                             "#{info[:example]}")
        else
          event.send_message("Search failed")
        end
      end
    
    end
    
  end
end