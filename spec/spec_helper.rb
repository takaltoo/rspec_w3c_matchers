require 'rubygems'
require 'rspec'
require 'rspec_w3c_matchers'

require 'shared_examples/notice_matcher'
require 'responses/responses'

Rspec.configure do |c|
  #  c.mock_with :mocha
  APP = RspecW3cMatchers
end

