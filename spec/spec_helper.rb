require 'rubygems'
require 'rspec'
require 'rspec_w3c_matchers'

require 'shared_examples/notice_matcher'
require 'shared_examples/matchers'
require 'responses/responses'

RSpec.configure do |config|
  #  c.mock_with :mocha
  APP = RspecW3cMatchers

  # include the matchers
  config.include(APP::InstanceMethods)

  config.raise_errors_for_deprecations!
end
