# require 'spec_helper'
# 
# module Prism
#   module FakeMinecraftConnection
#     def post_init
#       send_data ::MinecraftPackets.create_client 0x02, :username => 'whatupdave'
#     end
#     
#     def receive_data data
#       p data
#     end
#   end
#   
#   describe Client do
#     context "connection with username" do
#       it "should move to known player handler" do
#         EM.run do
#           EM.add_periodic_timer(0.1) { }
#           EM.start_server '0.0.0.0', 12345, Client do |client|
#             EM.add_timer(0.1) do
#               client.handler.class.should == KnownPlayerHandler
#               EM.stop
#             end
#           end
#           
#           EM.connect '0.0.0.0', 12345, FakeMinecraftConnection
#         end
#       end
#     end
#     
#   end
#   
# end