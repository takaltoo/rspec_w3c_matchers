module SampleResponses
  
  module Valid
    def self.html
      %q(
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <title>Clean Page</title>
        </head>
        <body>
          <h1>This is a clean page</h1>
          <p>Hello world</p>
        </body>
    </html>
    )
    end
    
    def self.response
      SampeResponses.load(:valid)
    end
  end

end