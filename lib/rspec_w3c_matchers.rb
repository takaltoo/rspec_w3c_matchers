require 'w3c_validators'
[
  'rspec_w3c_matchers/version.rb',
  'rspec_w3c_matchers/errors.rb',
  'rspec_w3c_matchers/warnings.rb',
  'rspec_w3c_matchers/helpers.rb',
  'rspec_w3c_matchers/matchers.rb'
].each do |file|
  require File.expand_path(File.dirname(__FILE__)) + '/' + file
end