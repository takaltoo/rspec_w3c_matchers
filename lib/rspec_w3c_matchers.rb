require 'w3c_validators'
[
  'rspec_w3c_matchers/version.rb',  
  'rspec_w3c_matchers/notices.rb',
  'rspec_w3c_matchers/matchers.rb'
].each do |file|
  require File.expand_path(File.dirname(__FILE__)) + '/' + file
end