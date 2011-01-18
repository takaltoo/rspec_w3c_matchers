shared_examples_for "w3c matcher for :== operator" do  
  it "returns true when response contains 0 notices and 0 expected" do     
    klass.new(clean_page,:==,0,type).matches?(clean_response).should be true
  end
  it "returns true when response contains 2 notices and 2 expected" do    
    klass.new(dirty_page,:==,2,type).matches?(dirty_response).should be true
  end   
  it "returns false when response contains 0 notices and 2 expected" do                
    klass.new(dirty_page,:==,2,type).matches?(clean_response).should be false
  end  
  it "returns false when response contains 2 notices and 0 expected" do                
    klass.new(dirty_page,:==,0,type).matches?(dirty_response).should be false
  end  
end


shared_examples_for "w3c matcher for :> operator" do  
  it "returns true when response contains 2 notices and >1 expected" do             
    klass.new(dirty_page,:>,1,type).matches?(dirty_response).should be true
  end   
  it "returns false when response contains 2 notices and >2 expected" do             
    klass.new(dirty_page,:>,2,type).matches?(dirty_response).should be false
  end  
end


shared_examples_for "w3c matcher for :< operator" do    
  it "returns true when response contains 0 notices and <2 expected" do             
    klass.new(clean_page,:<,2,type).matches?(clean_response).should be true
  end  
  it "returns false when response contains 2 notices and <2 expected" do             
    klass.new(dirty_page,:<,2,type).matches?(dirty_response).should be false
  end   
end

shared_examples_for "w3c matcher for :<= operator" do    
  it "returns true when response contains 2 notices and <=2 expected" do             
    klass.new(dirty_page,:<=,2,type).matches?(dirty_response).should be true
  end  
  it "returns true when response contains 2 notices and <=1 expected" do             
    klass.new(dirty_page,:<=,1,type).matches?(dirty_response).should be false
  end   
end

shared_examples_for "w3c matcher for :>= operator" do    
  it "returns true when response contains 2 notices and >=2 expected" do             
    klass.new(dirty_page,:>=,2,type).matches?(dirty_response).should be true
  end  
  it "returns true when response contains 0 notices and >=2 expected" do             
    klass.new(clean_page,:>=,2,type).matches?(clean_response).should be false
  end   
end

shared_examples_for "w3c matcher with detailed notice reporting" do
  
        
  context ":failure_message_for_should" do
    before(:each) do
      @matcher = klass.new(dirty_page,:==,0,type)
      @matcher.matches?(dirty_response)
      @matcher
    end
    
    let(:msg){@matcher.failure_message_for_should.split("\n")}
    
    it "returns proper header" do    
      num_matches(msg, /Expected \d+ W3C validation (errors|warnings) but received \d+ errors/)      
    end
    it "returns proper validator string" do
      num_matches(msg,/Checked by: \S+/).should be 1
    end    
    it "returns proper character set" do
      num_matches(msg,/Character set: \S+/).should be 1
    end
    it "returns proper number of notices" do      
      num_notices(msg)
      num_matches(msg,/#{type.to_s.capitalize}s?: \S+/).should be 1
    end
        
  end
  
  context ":failure_message_for_should_not" do
    before(:each) do
      @matcher = klass.new(dirty_page,:==,2,type)
      @matcher.matches?(dirty_response)
      @matcher
    end
    
    let(:matcher){@matcher}
    let(:msg){@matcher.failure_message_for_should_not.split("\n")}
    
    it "returns proper header" do
      num_matches(msg,/Did not expect \d+ W3C validation #{type}s? but received \d+ #{type}s?/)
    end
  end
  
  def num_matches(array,regexp)
    array.map do |string| 
      string =~ regexp
    end.keep_if do |value| value == 0 end.length
  end
  
  def num_notices(array)
    array.map do |string|
      matches = /#{type.to_s.capitalize}s?: (\d+)/.match(string)
      matches.nil? ? nil : matches[1].to_i
    end.keep_if do |value| !value.nil? end.first
  end

end

