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
