ENV["FOLD_ENV"] ||= 'test'

require 'bundler/setup'
Bundler.require :default, :proxy, :worker

require 'minefold'

RSpec.configure do |c|
  Fog.mock!
end