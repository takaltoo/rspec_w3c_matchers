require 'spec_helper'

describe APP::Notices do
  let(:klass) {APP::Notices}
  let(:notices) {klass}
  let(:validator){W3CValidators::MarkupValidator}
  
  let(:clean_page){ SampleResponses::Valid.html}
  let(:clean_response){ SampleResponses.load(:valid)}
  
  context "Errors" do 
    let(:type){:errors}    
    let(:dirty_page){ SampleResponses::Error.html}
    let(:dirty_response){ SampleResponses.load(:error)}
    
    it_should_behave_like "w3c matcher for :== operator"   
    it_should_behave_like "w3c matcher for :> operator"
    it_should_behave_like "w3c matcher for :< operator"
    it_should_behave_like "w3c matcher for :<= operator"
    it_should_behave_like "w3c matcher for :>= operator"
  end  
  
  context "Warnings" do
    let(:type){:warnings}
    let(:dirty_page){ SampleResponses::Warning.html}
    let(:dirty_response){ SampleResponses.load(:warning)}
    
    it_should_behave_like "w3c matcher for :== operator"   
    it_should_behave_like "w3c matcher for :> operator"
    it_should_behave_like "w3c matcher for :< operator"
    it_should_behave_like "w3c matcher for :<= operator"
    it_should_behave_like "w3c matcher for :>= operator"
  end
end
