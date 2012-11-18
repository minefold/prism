# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fakeredis/version"

Gem::Specification.new do |s|
  s.name        = "fakeredis"
  s.version     = FakeRedis::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Guillermo Iguaran"]
  s.email       = ["guilleiguaran@gmail.com"]
  s.homepage    = "https://github.com/guilleiguaran/fakeredis"
  s.summary     = %q{Fake (In-memory) driver for redis-rb.}
  s.description = %q{Fake (In-memory) driver for redis-rb. Useful for testing environment and machines without Redis.}

  s.rubyforge_project = "fakeredis"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency(%q<redis>, ["~> 2.2.0"])
  s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
end
