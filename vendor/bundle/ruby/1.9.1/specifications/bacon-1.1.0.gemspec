# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bacon"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christian Neukirchen"]
  s.date = "2008-11-29"
  s.description = "Bacon is a small RSpec clone weighing less than 350 LoC but nevertheless providing all essential features.  http://github.com/chneukirchen/bacon"
  s.email = "chneukirchen@gmail.com"
  s.executables = ["bacon"]
  s.extra_rdoc_files = ["README", "RDOX"]
  s.files = ["bin/bacon", "README", "RDOX"]
  s.homepage = "http://chneukirchen.org/repos/bacon"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "a small RSpec clone"

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
