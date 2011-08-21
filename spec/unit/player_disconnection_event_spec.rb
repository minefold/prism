require 'spec_helper'

module Prism
  describe PlayerDisconnectionEvent do
    let(:request) { PlayerDisconnectionEvent.new }
    let(:redis) { EM::FakeRedis }
    
    specify { PlayerDisconnectionEvent.queue.should == "players:disconnection_request" }
    
    context "on process disconnection" do
      context "when last player out" do
        before { 
          redis.internal_hashes["players:playing"] = {"whatupdave" => "world1"}
          redis.internal_sets["worlds:world1:connected_players"] = ["whatupdave"]
          redis.internal_hashes["worlds:running"] = {"world1" => {instance_id:'i-1234', host:'0.0.0.0', port:'0.0.0.0'}.to_json }
          
          request.process "whatupdave" 
        }
        
        it "should request to stop world" do
          redis.internal_lists["worlds:requests:stop"].should include({instance_id:"i-1234", world_id:"world1"}.to_json)
        end
        
        specify { redis.internal_hashes["players:playing"].should_not include({"whatupdave" => "world1"}) }
        specify { redis.internal_sets["worlds:world1:connected_players"].should_not include("whatupdave") }
      end
      
    end
  end
end