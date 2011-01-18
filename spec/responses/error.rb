module SampleResponses
  
  module Error
    def self.html
    %q(
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <title>Two Error</title>
        </head>
        <body>
          <h1>Page with a Two Errors</h1>
          <p>Hello world</p>
          <usr_nav></usr_nav>
          <boo_boo></boo_boo>
        </body>
      </html>
      )
    end
    
    def self.response
      SampeResponses.load(:error)
    end
  end

end