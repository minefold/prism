# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "foreman"
  s.version = "0.19.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Dollar"]
  s.date = "2011-06-26"
  s.description = "Process manager for applications with multiple components"
  s.email = "ddollar@gmail.com"
  s.executables = ["foreman"]
  s.files = ["bin/foreman"]
  s.homepage = "http://github.com/ddollar/foreman"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Process manager for applications with multiple components"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<term-ansicolor>, ["~> 1.0.5"])
      s.add_runtime_dependency(%q<thor>, [">= 0.13.6"])
      s.add_development_dependency(%q<parka>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<ronn>, [">= 0"])
      s.add_development_dependency(%q<fakefs>, ["~> 0.2.1"])
      s.add_development_dependency(%q<rcov>, ["~> 0.9.8"])
      s.add_development_dependency(%q<rr>, ["~> 1.0.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
    else
      s.add_dependency(%q<term-ansicolor>, ["~> 1.0.5"])
      s.add_dependency(%q<thor>, [">= 0.13.6"])
      s.add_dependency(%q<parka>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<ronn>, [">= 0"])
      s.add_dependency(%q<fakefs>, ["~> 0.2.1"])
      s.add_dependency(%q<rcov>, ["~> 0.9.8"])
      s.add_dependency(%q<rr>, ["~> 1.0.2"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    end
  else
    s.add_dependency(%q<term-ansicolor>, ["~> 1.0.5"])
    s.add_dependency(%q<thor>, [">= 0.13.6"])
    s.add_dependency(%q<parka>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<ronn>, [">= 0"])
    s.add_dependency(%q<fakefs>, ["~> 0.2.1"])
    s.add_dependency(%q<rcov>, ["~> 0.9.8"])
    s.add_dependency(%q<rr>, ["~> 1.0.2"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
  end
end
