require 'spec_helper'

describe APP do
  let(:klass){APP}
  context "class methods" do
    it "should have VERSION constant" do
      expect(klass.constants).to include(:VERSION)
    end
    specify { expect(klass).to respond_to(:version)}
    context "version" do
      it "should return the VERSION constant" do
        expect(klass.version).to eq klass::VERSION
      end
    end
  end
end
