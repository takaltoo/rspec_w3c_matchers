require 'spec_helper'

describe APP do
  let(:klass){APP}  
  context "class methods" do
    it "should have VERSION constant" do
      klass.constants.include?(:VERSION).should be true
    end
    specify {klass.should respond_to(:version)}
    context "version" do
      it "should return the VERSION constant" do
        klass.version.should == klass::VERSION
      end
    end
  end
end