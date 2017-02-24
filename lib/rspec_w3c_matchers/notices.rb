module RspecW3cMatchers
  # Low level matcher that is used as a base for the high level matchers.
  # You should not need to use this class directly. Look at the definitions in
  # RspecW3cMatchers::InstanceMethods for a complete list of available matchers.
  #
  # The arguments to Notice are as follows:
  #
  #   page: text containing the html that is being validated
  #   comparator: comparison to be performed, can be :==,:<,:>,:<=,:>=. The number of errors
  #             or warnings in the response is compared against the msg_count using this operator.
  #   msg_count: expected number of notices
  #   type: message type, either :errors or :warnings
  #
  # To create a matcher that checks whether a response has more than 2 warnings you would use the
  # declaration:
  #
  #   RspecW3cMatchers::Notices.new(page,:>,2,:warnings)
  #
  # To create a matcher that checks to make sure a response has exactly 1 error you would use the
  # declaration:
  #
  #   RspecW3cMatchers::Notices.new(page,:==,1,:errors)
  #
  class Notices
    def initialize(page,comparator,msg_count,type)
      @page = page
      @msg_count = msg_count
      self.comparator = comparator
      self.type = type
    end

    # Used by the should() and should_not() methods to determine whether the expectation passes or fails.
    def matches?(response)
      @response = response
      notices.length.send(@comparator,@msg_count)
    end

    # The failure message used when should() is used and the matches?() method returns false.
    def failure_message
      ["Expected #{comparison}#{@msg_count} W3C validation #{type} but received #{notices.length} #{type}",
        summary
      ].join("\n")
    end

    # The failure message used when should_not() is used and the matches?() method returns true.
    def failure_message_when_negated
      ["Did not expect #{comparison}#{@msg_count} W3C validation #{type} but received #{notices.length} #{type}",
        summary
      ].join("\n")
    end

    # description that is returned when none is provided
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
