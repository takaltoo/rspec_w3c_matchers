require 'ruby-debug'
module RspecW3cMatchers
  
  class Notices
    def initialize(page,comparator,msg_count,type)
      @page = page
      @msg_count = msg_count
      self.comparator = comparator
      self.type = type
    end

    def matches?(response)
      @response = response      
      notices.length.send(@comparator,@msg_count)
    end
    
    def failure_message_for_should          
      ["Expected #{comparison}#{@msg_count} W3C validation #{type} but received #{notices.length} #{type}",
        summary        
      ].join("\n")
    end

    def failure_message_for_should_not      
      ["Did not expect #{comparison}#{@msg_count} W3C validation #{type} but was received #{notices.length} #{type}",
        summary        
      ].join("\n")
    end

    def description
      "should receive #{comparison}#{@msg_count} W3C validation #{type} in #{uri}"
    end

    private
    def notices      
      @response.send(@type.to_s)
    end
    
    def summary
      (
        ["Checked by: %s" % @response.checked_by,
          "Document type: %s" % @response.doctype,
          "Character set: %s" % @response.charset,
          "\n#{@type.capitalize}: %s\n" % [notices.length]
        ].join("\n") + 
        messages
      )
    end

    def messages
      notices.map do |message|
        ["Type: %s" % message.type,
        "Location: line '%s' column '%s'" %[message.line,message.col],
        "URI: %s" % uri,
        "Message: %s" % message.message,
        "Source (line #{message.line}): \n%s\n" % extract_source(message.line)].join("\n")
      end.join("\n"*2)
    end
            
    def extract_source(line)      
      body.split("\n")[line.to_i-1]
    end
    
    def uri
      @page.respond_to?(:current_path) ? @page.current_path : '(Unknown, input probably came from text)'
    end
    
    def body
      @page.respond_to?(:body) ? @page.body : @page.to_s
    end
    
    def type
      @msg_count == 1 ? @type.to_s[0..-2] : @type.to_s
    end
    
    def comparison
      case @comparator
      when :== then
        ''
      when :<= then
        'less than or equal to '
      when :>= then
        'greater than or equal to '
      when :< then
        'less than '
      when :> then
        'greater than '
      else
        ''
      end
    end
    
    def comparator=(value)
      raise ArgumentError unless [:==,:<=,:>=,:<,:>].include?(value)
      @comparator = value
    end
    
    def type=(value)
      raise ArgumentError unless [:errors,:warnings].include?(value)
      @type = value
    end
       
  end
  
end
