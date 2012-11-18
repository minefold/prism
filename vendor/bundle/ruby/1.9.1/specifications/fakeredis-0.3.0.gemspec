# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "fakeredis"
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Guillermo Iguaran"]
  s.date = "2012-03-01"
  s.description = "Fake (In-memory) driver for redis-rb. Useful for testing environment and machines without Redis."
  s.email = ["guilleiguaran@gmail.com"]
  s.homepage = "https://github.com/guilleiguaran/fakeredis"
  s.require_paths = ["lib"]
  s.rubyforge_project = "fakeredis"
  s.rubygems_version = "1.8.23"
  s.summary = "Fake (In-memory) driver for redis-rb."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis>, ["~> 2.2.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
    else
      s.add_dependency(%q<redis>, ["~> 2.2.0"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<redis>, ["~> 2.2.0"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
  end
end
