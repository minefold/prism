require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["FOLD_ENV"] ||= 'test'
  
  REDISTOGO_URL = nil

  require 'bundler/setup'
  Bundler.require :default, :test, :proxy, :worker

  RSpec.configure do |c|
    Fog.mock!
    c.mock_with :rr
  end
end

Spork.each_run do
  require 'minefold'
  require 'prism/front'
  require 'prism/back'
  Dir[File.join File.dirname(__FILE__), "support/**/*.rb"].each {|f| require f}
  
  module Debugger
    def debug *args; end
    def info *args; end
    def error *args; end
  end
  
  RSpec.configure do  |c|
    c.before(:each) { EM::FakeRedis.reset }
  end
  
end

