# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "em-hiredis"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Martyn Loughran"]
  s.date = "2012-02-27"
  s.description = "Eventmachine redis client using hiredis native parser"
  s.email = ["me@mloughran.com"]
  s.homepage = "http://github.com/mloughran/em-hiredis"
  s.require_paths = ["lib"]
  s.rubyforge_project = "em-hiredis"
  s.rubygems_version = "1.8.23"
  s.summary = "Eventmachine redis client"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hiredis>, ["~> 0.4.0"])
      s.add_development_dependency(%q<em-spec>, ["~> 0.2.5"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<hiredis>, ["~> 0.4.0"])
      s.add_dependency(%q<em-spec>, ["~> 0.2.5"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<hiredis>, ["~> 0.4.0"])
    s.add_dependency(%q<em-spec>, ["~> 0.2.5"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
