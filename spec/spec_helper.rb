require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["FOLD_ENV"] ||= 'test'

  require 'bundler/setup'
  Bundler.require :default, :test, :proxy, :worker

  require 'minefold'

  RSpec.configure do |c|
    Fog.mock!
    c.mock_with :rr
  end
end

Spork.each_run do
  require 'prism'
  Dir[File.join File.dirname(__FILE__), "support/**/*.rb"].each {|f| p f; require f}
end

