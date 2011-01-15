module RspecW3cMatchers
  
  class Errors

    def initialize(page,errors,comparator=:==)
      @page = page
      @errors = errors
      @comparator = comparator
    end

    def matches?(response)
      @response = response
      @response.errors.length.send(@comparator,@errors)
    end
    
    def failure_message_for_should
      ["expected #{@errors} w3c validation errors but received #{@response.errors.length}",
        Helpers.response_description(@response),
        Helpers.response_messages(@page,@response.errors)
      ].join("\n")
    end

    def failure_message_for_should_not      
      ["did not expect to receive #{@response.errors.length} w3c validation errors",
        Helpers.response_description(@response),
        Helpers.response_messages(@page,@response.errors)
      ].join("\n")
    end

    def description
      "should receive #{@errors} W3c errors in #{uri}"
    end

    private
    def uri
      @page.respond_to?(:current_path) ? @page.current_path : '(Unknown, input probably came from text)'
    end
    
    
  end
  
end
