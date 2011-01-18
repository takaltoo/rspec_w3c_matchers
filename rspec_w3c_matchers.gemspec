# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rspec_w3c_matchers/version"

Gem::Specification.new do |s|
  s.name        = "rspec_w3c_matchers"
  s.version     = RspecW3cMatchers::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Takaltoo"]
  s.email       = ["pouya@lavabit.com"]
  s.homepage    = "http://rubygems.org/gems/rspec_w3c_matchers"
  s.summary     = %q{Rspec 2.0 matchers that detect and report detailed error and warning
                     responses from w3c_validators GEM.}
  s.description = %q{ add description}

  s.rubyforge_project = "rspec_w3c_matchers"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_runtime_dependency(%q<w3c_validators>, [">= 1.1.1"])    
  s.add_development_dependency(%q<rspec>, [">= 2.3.0"])
  

end
