require 'bundler/setup'
Bundler.require :default, :test

ENV["FOLD_ENV"] ||= 'test'
require 'minefold'
require 'prism/front'
require 'prism/back'

Dir["#{Fold.root}/spec/support/**/*.rb"].each {|f| require f}

module Debugger
  # def debug *args; end
  def info *args; end
  def error *args; end
end

RSpec.configure do |config|
  config.mock_with :rspec

  Fog.mock!
end
