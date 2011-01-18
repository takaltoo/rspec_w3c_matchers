require 'spec_helper'

describe APP do  
  let(:klass) {APP}
  let(:matcher) {klass}
  let(:clean_page){ SampleResponses::Valid.html}
  let(:clean_response){ SampleResponses.load(:valid)}   
  
  context "Errors" do    
    let(:type){:errors}        
    let(:dirty_page){SampleResponses::Error.html}
    let(:dirty_response){SampleResponses.load(:error)}
    
    it_should_behave_like "w3c notices matcher for have no"   
    it_should_behave_like "w3c notices matcher for have more than zero"  
    it_should_behave_like "w3c notices matcher for have specified"   
    it_should_behave_like "w3c notices matcher for have more than" 
    it_should_behave_like "w3c notices matcher for have greater than or equal to" 
    it_should_behave_like "w3c notices matcher for have less than"  
    it_should_behave_like "w3c notices matcher for have less than or equal to"  
  end  
  
  context "Warnings" do
    let(:type){:warnings}    
    let(:dirty_page){SampleResponses::Warning.html}
    let(:dirty_response){SampleResponses.load(:warning)}
    
    it_should_behave_like "w3c notices matcher for have no"   
    it_should_behave_like "w3c notices matcher for have more than zero"  
    it_should_behave_like "w3c notices matcher for have specified"   
    it_should_behave_like "w3c notices matcher for have more than" 
    it_should_behave_like "w3c notices matcher for have greater than or equal to" 
    it_should_behave_like "w3c notices matcher for have less than"  
    it_should_behave_like "w3c notices matcher for have less than or equal to"  
  end
end
