ENV['FOLD_ENV'] ||= 'development'

$:.unshift File.join File.dirname(__FILE__), '../config'

require 'minefold/minefold_db'
require 'minefold/local_worlds'
require 'minefold/storage'
require 'minefold/workers'
require 'minefold/worker'
require 'minefold/worlds'
require 'minefold/world'
require ENV['FOLD_ENV']
