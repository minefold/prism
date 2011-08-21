require 'spec_helper'

module Prism
  describe PlayerConnectionRequest do
    let(:request) { PlayerConnectionRequest.new }
    let(:redis) { EM::FakeRedis }
    
    specify { PlayerConnectionRequest.queue.should == "players:connection_request" }
    
    before {
      stub(request).mongo_connect.returns(@mongo = Object.new)
      stub(@mongo).collection('users').returns(@users = Object.new)
    }
    
    context "when player exists" do
      let(:user_oid) { BSON::ObjectId.new }
      
      before { 
        # redis.internal_hashes["players:playing"] = {"whatupdave" => "world1"}
        # redis.internal_sets["worlds:world1:connected_players"] = ["whatupdave"]
        # redis.internal_hashes["worlds:running"] = {"world1" => {instance_id:'i-1234', host:'0.0.0.0', port:'0.0.0.0'}.to_json }
        
        mock(@users).find_one(:username => /whatupdave/i).returns({'_id' => user_oid, 'world_id' => 'world1'})
        
        request.process "whatupdave" 
      }
      
      it "should request player world" do
        redis.internal_lists["players:world_request"].should include({username:"whatupdave", user_id:"#{user_oid}", world_id:"world1"}.to_json)
      end
      
      specify { redis.internal_hashes["usernames"].should include({"whatupdave" => "#{user_oid}"}) }
    end
  end
end