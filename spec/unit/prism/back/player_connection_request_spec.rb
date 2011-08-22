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
    
    let(:user_oid) { BSON::ObjectId.new }
    
    context "when player exists" do
      before { 
        mock(@users).find_one(:username => /whatupdave/i).returns({'_id' => user_oid, 'world_id' => 'world1'})
        
        request.process "whatupdave" 
      }
      
      it "should request player world" do
        redis.internal_lists["players:world_request"].should include({username:"whatupdave", user_id:"#{user_oid}", world_id:"world1"}.to_json)
      end
      
      specify { redis.internal_hashes["usernames"].should include({"whatupdave" => "#{user_oid}"}) }
    end
    
    context "when player doesn't exist" do
      before { 
        mock(@users).find_one(:username => /cjwoodward/i).returns(nil)
        
        request.process "cjwoodward" 
      }
      
      it "should publish error" do
        redis.internal_published["players:connection_request:cjwoodward"].should include(nil)
      end
      
      
    end
  end
end