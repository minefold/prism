require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["FOLD_ENV"] ||= 'test'

  require 'bundler/setup'
  Bundler.require :default, :test, :proxy, :worker

  require 'minefold'
  require 'support/fake_redis'

  RSpec.configure do |c|
    Fog.mock!
    c.mock_with :rr
    
    c.before(:each) { EM::FakeRedis.reset }
  end
end

Spork.each_run do
  require 'prism/front'
  require 'prism/back'
  Dir[File.join File.dirname(__FILE__), "support/**/*.rb"].each {|f| require f}
  
  module Debugger
    def debug *args; end
  end
end

