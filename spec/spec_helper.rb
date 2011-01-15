require 'rubygems'
require 'rspec'
require 'rspec_w3c_matchers'

Rspec.configure do |c|
  #  c.mock_with :mocha
  APP = RspecW3cMatchers
end

