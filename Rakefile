$:.unshift File.join File.dirname(__FILE__), 'lib'
require 'rake/clean'

CLEAN.add 'tmp'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  t.pattern = 'spec/**/*_spec.rb'
end

require 'resque/tasks'

task "resque:setup" do
  require 'environment'
  require 'jobs'
  require 'fog'
end

