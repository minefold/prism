ENV['FOLD_ENV'] ||= 'development'

module Fold
  class << self
    attr_accessor :workers
    
    def env
      ENV['FOLD_ENV'].to_sym
    end
    
    def compute_cloud
      @@compute_cloud ||= Fog::Compute.new({
        :provider                 => 'AWS',
        :aws_secret_access_key    => EC2_SECRET_KEY,
        :aws_access_key_id        => EC2_ACCESS_KEY
      })
    end
  end
end

$:.unshift File.join File.dirname(__FILE__), '../config'

require 'minefold/minefold_db'
require 'minefold/local_worlds'
require 'minefold/storage'
# require 'minefold/workers'
require 'minefold/worker'
require 'minefold/worlds'
require 'minefold/world'
require "#{Fold.env}"
