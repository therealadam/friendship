# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "friendship/version"

Gem::Specification.new do |s|
  s.name        = "friendship"
  s.version     = Friendship::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = "http://rubygems.org/gems/friendship"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "friendship"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activesupport", "~> 3.0.0"
  s.add_dependency "i18n", "~> 0.4.2" # Why doesn't AS declare this dep?

  s.add_development_dependency "cassandra"
  s.add_development_dependency "redis"
  s.add_development_dependency "SystemTimer"
  s.add_development_dependency "rspec", "~> 2.2.0"

end
