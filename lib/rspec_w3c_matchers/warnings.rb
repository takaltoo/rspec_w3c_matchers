module RspecW3cMatchers
  
  class Warnings
    def initialize(page,warnings)
      @page = page
      @warnings = warnings
    end

    def matches?(response)
      @response = response
      case @warnings
      when 0 then
        @response.warnings.length != @warnings
      else
        @response.warnings.length == @warnings
      end
    end

    def failure_message_for_should
      ["expected #{@warnings} w3c validation errors but received #{@response.warnings.length}",
        Helpers.response_description(@response),
        Helpers.response_messages(@page,@response.warnings)
      ].join("\n")
    end

    def failure_message_for_should_not
      ["did not expect to receive #{@response.warnings.length} w3c validation warnings",
        Helpers.response_description(@response),
        Helpers.response_messages(@page,@response.warnings)
      ].join("\n")
    end

    def description
      "should receive #{@warnings} W3c warnings in #{uri}"
    end
    
    private
    def uri
      @page.respond_to?(:current_path) ? @page.current_path : '(Unknown, input probably came from text)'
    end
    

  end

end