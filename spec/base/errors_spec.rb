require 'spec_helper'

describe APP::Errors do
  let(:klass) {APP::Errors}
  let(:errors) {klass}
  let(:validator){W3CValidators::MarkupValidator}
  
  let(:clean_page){ 
    %q(
      <!DOCTYPE html> 
      <html lang="en"> 
         <head>
          <title>Zero Errors</title>
          <meta charset="utf-8" />
         </head> 
         <body>
            <h1>Page has No Errors</h1>
         </body>    
      </html>
      ) 
  }
  
  let(:dirty_page){
    %q(
      <!DOCTYPE html> 
      <html lang="en"> 
        <head>
          <title>One Error</title>
          <meta charset="utf-8" />
        </head> 
        <body>
          <h1>Page has One Error</h1>
          <user_nav></user_nav>
        </body>    
      </html> 
      )
    }
  
  let(:dirty_response){
    @dirty_response ||= validator.new.validate_text(dirty_page)
    @dirty_response
  }
        
  let(:clean_response){
    @clean_response ||= validator.new.validate_text(clean_page)
    @clean_response
  }
  
  
  context "Errors matcher" do 
    it "returns false when response contains 1 errors and 0 expected" do        
      dirty_response.should errors.new(dirty_page,1,:<)
    end
    it "returns true when response contains 0 errors and 0 expected" do       
      clean_response.should errors.new(clean_page,0,:==)
    end
    it "returns false when response contains 0 errors and 1 expected" do      
      clean_response.should_not errors.new(clean_page,1,:==)
    end
    it "returns true when response contains 1 errors and 1 expected" do
      dirty_response.should errors.new(dirty_page,1,:==)     
    end    
  end
  
end

