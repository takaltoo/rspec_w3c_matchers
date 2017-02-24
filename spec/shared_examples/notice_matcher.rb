shared_examples_for "w3c matcher for :== operator" do
  it "returns true when response contains 0 notices and 0 expected" do
    expect(klass.new(clean_page,:==,0,type).matches?(clean_response)).to be_truthy
  end
  it "returns true when response contains 2 notices and 2 expected" do
    expect(klass.new(dirty_page,:==,2,type).matches?(dirty_response)).to be_truthy
  end
  it "returns false when response contains 0 notices and 2 expected" do
    expect(klass.new(dirty_page,:==,2,type).matches?(clean_response)).to be_falsey
  end
  it "returns false when response contains 2 notices and 0 expected" do
    expect(klass.new(dirty_page,:==,0,type).matches?(dirty_response)).to be_falsey
  end
end


shared_examples_for "w3c matcher for :> operator" do
  it "returns true when response contains 2 notices and >1 expected" do
    expect(klass.new(dirty_page,:>,1,type).matches?(dirty_response)).to be_truthy
  end
  it "returns false when response contains 2 notices and >2 expected" do
    expect(klass.new(dirty_page,:>,2,type).matches?(dirty_response)).to be_falsey
  end
end


shared_examples_for "w3c matcher for :< operator" do
  it "returns true when response contains 0 notices and <2 expected" do
    expect(klass.new(clean_page,:<,2,type).matches?(clean_response)).to be_truthy
  end
  it "returns false when response contains 2 notices and <2 expected" do
    expect(klass.new(dirty_page,:<,2,type).matches?(dirty_response)).to be_falsey
  end
end

shared_examples_for "w3c matcher for :<= operator" do
  it "returns true when response contains 2 notices and <=2 expected" do
    expect(klass.new(dirty_page,:<=,2,type).matches?(dirty_response)).to be_truthy
  end
  it "returns true when response contains 2 notices and <=1 expected" do
    expect(klass.new(dirty_page,:<=,1,type).matches?(dirty_response)).to be_falsey
  end
end

shared_examples_for "w3c matcher for :>= operator" do
  it "returns true when response contains 2 notices and >=2 expected" do
    expect(klass.new(dirty_page,:>=,2,type).matches?(dirty_response)).to be_truthy
  end
  it "returns true when response contains 0 notices and >=2 expected" do
    expect(klass.new(clean_page,:>=,2,type).matches?(clean_response)).to be_falsey
  end
end

shared_examples_for "w3c matcher with description when none provided"   do
  let(:regexp){Regexp.new("^should receive 0 W3C validation #{type} in")}
  it "returns proper description" do
    matcher = klass.new(dirty_page,:==,0,type)
    matcher.matches?(dirty_response)
    expect(regexp.match(matcher.description)).not_to be_nil
  end
end

shared_examples_for "w3c matcher with detailed notice reporting" do
  let(:regexp_should_header){Regexp.new("Expected (?<expected>\\d+) W3C validation #{type.to_s}? but received (?<actual>\\d+) #{type.to_s}?")}
  let(:regexp_should_not_header){Regexp.new("Did not expect (?<expected>\\d+) W3C validation #{type.to_s}? but received (?<actual>\\d+) #{type.to_s}?")}

  context ":failure_message" do
    before(:each) do
      @matcher = klass.new(dirty_page,:==,0,type)
      @matcher.matches?(dirty_response)
      @matcher
    end

    let(:msg){@matcher.failure_message.split("\n")}

    it "returns proper header" do
      expect(num_matches(msg, regexp_should_header)).to eq 1
    end
    it_behaves_like "w3c detailed notices"
  end

  context ":failure_message_when_negated" do
    before(:each) do
      @matcher = klass.new(dirty_page,:==,2,type)
      @matcher.matches?(dirty_response)
      @matcher
    end

    let(:matcher){@matcher}
    let(:msg){@matcher.failure_message_when_negated.split("\n")}

    it "returns proper header" do
      expect(num_matches(msg, regexp_should_not_header)).to eq 1
    end
    it_behaves_like "w3c detailed notices"
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

  def expected_notices(array)
    abc = array.map do |string|

      if (matches = regexp_should_header.match(string)) || (matches = regexp_should_not_header.match(string))
        matches['expected'].to_i
      else
        nil
      end
    end.keep_if do |value| !value.nil? end.first
  end
end

shared_examples_for "w3c detailed notices" do
  it "returns proper validator string" do
    expect(num_matches(msg,/^\s*Checked by: \S+/)).to eq 1
  end
  it "returns proper character set" do
    expect(num_matches(msg,/^\s*Character set: \S+/)).to eq 1
  end
  it "returns proper number of notices" do
    expect(num_matches(msg,/^\s*#{type.to_s.capitalize}s?: \S+/)).to eq 1
  end
  it "returns Type declaration for every notice" do
    expect(num_matches(msg,/^\s*Type: #{type}?/)).to be num_notices(msg)
  end
  it "returns Location declaration for every notice" do
    expect(num_matches(msg,/^\s*Location: line \S+ column \S+/)).to be num_notices(msg)
  end
  it "returns URI declaration for every notice" do
    expect(num_matches(msg,/^\s*URI: .*/)).to be num_notices(msg)
  end
  it "returns Message declaration for every notice" do
    expect(num_matches(msg,/^\s*Message: .*/)).to be num_notices(msg)
  end
  it "returns expected number of Source declarations" do
    expect(num_matches(msg,/^\s*Source \(line \d*\): .*/)).to be num_notices(msg)
  end
end
