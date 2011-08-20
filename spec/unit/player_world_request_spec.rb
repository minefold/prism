require 'spec_helper'

module Prism
  describe PlayerWorldRequest do
    let(:redis) { EM::FakeRedis }
    before { redis.reset }
  
    context "player connects" do
      let(:request) { PlayerWorldRequest.new }
      
      context "requested world is running" do
        before {
          redis.internal_hashes["worlds:running"] = {"world1" => { instance_id:"i-1234", host:"0.0.0.0", port:"4000" }.to_json }
          request.run "whatupdave", "user1", "world1"
        }
        
        it "should connect player to world" do
          redis.internal_published["players:connection_request:whatupdave"].should include({host:"0.0.0.0", port:"4000"}.to_json)
        end
      end
    end
  end
end