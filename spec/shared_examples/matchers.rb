shared_examples_for "w3c notices matcher for have no" do
  let(:method){"have_no_w3c_#{type}_in".to_sym}
  
  it "should return true with valid page" do    
    self.send(method,clean_page).matches?(clean_response).should be true
  end
  it "should return false for invalid page" do
    self.send(method,dirty_page).matches?(dirty_response).should be false
  end
end

shared_examples_for "w3c notices matcher for have more than zero" do
  let(:method){"have_w3c_#{type}_in"}
  
  it "should return true for invalid page" do    
    self.send(method,dirty_page).matches?(dirty_response).should be true
  end
  it "should return false for valid page" do
    self.send(method,clean_page).matches?(clean_response).should be false
  end
end

shared_examples_for "w3c notices matcher for have specified" do
  let(:method){"have_specified_number_of_w3c_#{type}_in"}
  
  it "should return true when 2 notices expected and page contains 2 notices" do
    self.send(method,dirty_page,2).matches?(dirty_response).should be true
  end
  it "should return false when 3 notices expected and page contains 2 notices" do
    self.send(method,dirty_page,3).matches?(dirty_response).should be false
  end
end

shared_examples_for "w3c notices matcher for have more than"  do
  let(:method){"have_more_than_specified_number_of_#{type}_in"}
  
  it "should return true when 1 notice expected and page contains 2 notices" do    
    self.send(method,dirty_page,1).matches?(dirty_response).should be true
  end
  it "should return false when 2 notices expected and page contains 2 notices" do
    self.send(method,dirty_page,2).matches?(dirty_response).should be false
  end 
end

shared_examples_for "w3c notices matcher for have greater than or equal to"  do
  let(:method){"have_greater_than_or_equal_to_specified_number_of_#{type}_in"}
  
  it "should return true when 1 notice expected and page contains 2 notices" do    
    self.send(method,dirty_page,1).matches?(dirty_response).should be true
  end
  it "should return true when 2 notices expected and page contains 2 notices" do
    self.send(method,dirty_page,2).matches?(dirty_response).should be true
  end 
  it "should return false when 3 notices expected and page contains 2 notices" do
    self.send(method,dirty_page,3).matches?(dirty_response).should be false
  end 
end

shared_examples_for "w3c notices matcher for have less than" do
  let(:method){"have_less_than_specified_number_of_#{type}_in"}
  it "should return true when 3 notice expected and page returns 2 notices" do
    self.send(method,dirty_page,3).matches?(dirty_response).should be true
  end
  it "should return false when 2 notices expected and page returns 2 notices" do
    self.send(method,dirty_page,2).matches?(dirty_response).should be false
  end
end

shared_examples_for "w3c notices matcher for have less than or equal to" do
  let(:method){"have_less_than_or_equal_to_specified_number_of_#{type}_in"}  
  it "should return true when 2 notices expected and page returns 2 notices" do
    self.send(method,dirty_page,2).matches?(dirty_response).should be true
  end
  it "should return true when 2 notices expected and page returns 1 notice" do
    self.send(method,dirty_page,2).matches?(dirty_response).should be true
  end
  it "should return false when 1 notice expected and page returns 2 notices" do
    self.send(method,dirty_page,1).matches?(dirty_response).should be false
  end
end
