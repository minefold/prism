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
      
      context "requested world is not running" do
        context "a running worker is available" do
          before {
            redis.internal_hashes["workers:running"] = {"i-1234" => { instance_id:"i-1234", host:"0.0.0.0", started_at:Time.now.utc.to_s }.to_json}
            request.run "whatupdave", "user1", "world1"
          }
        
          it "should request world start" do
            redis.internal_lists["worlds:requests:start"].should include({instance_id:"i-1234", world_id:"world1", min_heap_size:512, max_heap_size:2048}.to_json)
          end
          
        end
        
        context "a sleeping worker is available" do
          before {
            redis.internal_sets["workers:sleeping"] = ["i-1234"]
            request.run "whatupdave", "user1", "world1"
          }
        
          it "should request worker start" do
            redis.internal_lists["workers:requests:start"].should include("i-1234")
          end
        end

        context "no worker is available" do
          before {
            request.run "whatupdave", "user1", "world1"
          }
        
          it "should request worker create" do
            redis.internal_lists["workers:requests:create"].should have(1).request
          end
        end
      end
      
    end
  end
end