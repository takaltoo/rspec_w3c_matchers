module SampleResponses
  
  module Warning
  
    def self.html
      %q(
      <!DOCTYPE html5>
      <html>
        <head>
          <title>Single Warning</title>
        </head>
        <body>
          <h1>Page with a Single Warning</h1>
          <p>Hello world</p>
          <br/>
        </body>
      </html>
      )
    end
    
    def self.response
      SampeResponses.load(:warning)
    end
  end

end