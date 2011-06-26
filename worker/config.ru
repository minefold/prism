require 'bundler'
Bundler.require :default, :worker, ENV['RACK_ENV'].to_sym

$:.unshift File.join File.dirname(__FILE__), '../lib'
require 'environment'
require 'minefold'

require './app'
run Sinatra::Application