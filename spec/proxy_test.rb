#!/usr/bin/env ruby
# encoding: UTF-8
require 'bundler/setup'
Bundler.require :default, :proxy

module ProxyConnection
  def initialize(client, request)
    @client, @request = client, request
  end

  def post_init
    EM::enable_proxy(self, @client)
  end

  def connection_completed
    send_data @request
  end

  def proxy_target_unbound
    close_connection
  end

  def unbind
    @client.close_connection_after_writing
  end
end

module ProxyServer
  def receive_data(data)
    (@buf ||= "") << data
    EM.connect("0.0.0.0", 4000, ProxyConnection, self, data)
  end
end

EM.run {
  EM.start_server("0.0.0.0", 25565, ProxyServer)
  
  puts "listening"
}