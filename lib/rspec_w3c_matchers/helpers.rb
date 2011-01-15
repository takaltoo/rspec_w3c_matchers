module RspecW3cMatchers
  
  module Helpers
    def self.response_description(response)
      ["Checked by: %s" % response.checked_by,
        "Document type: %s" % response.doctype,
        "Character set: %s" % response.charset,
        "\nWarnings: %s, Errors: %s,\n" % [response.warnings.length,response.errors.length]
      ].join("\n")
    end

    def self.response_messages(page,messages)
      messages.map do |message|
        Helpers.message_description(page,message)
      end.join("\n\n")
    end

    def self.message_description(page,message)
      ["Type: %s" % message.type,
        "Location: line '%s' column '%s'" %[message.line,message.col],
        "URI: %s" % self.uri(page),
        "Message: %s" % message.message,
        "Source (line #{message.line}): \n%s\n" % self.extract_source(page,message.line.to_i)].join("\n")
    end
    
    private
    def self.extract_source(page,line)      
      body = self.body(page).split("\n")
      body[line-1]
    end
    
    def self.uri(page)
      page.respond_to?(:current_path) ? page.current_path : '(Unknown, input probably came from text)'
    end
    
    def self.body(page)
      page.respond_to?(:body) ? page.body : page.to_s
    end
    
  end

end