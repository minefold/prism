require 'spec_helper'

def world_running name, options
  EM::FakeRedis.internal_hashes["worlds:running"] = {name => options.to_json }
end

module Prism
  describe PlayerWorldRequest do
    let(:redis) { EM::FakeRedis }
  
    context "player connects" do
      let(:request) { PlayerWorldRequest.new }
      
      context "requested world is running" do
        before {
          world_running "world1", instance_id:"i-1234", host:"0.0.0.0", port:"4000"
          request.process({username:"whatupdave", user_id:"user1", world_id:"world1"}.to_json)
        }
        
        it "should connect player to world" do
          redis.internal_published["players:connection_request:whatupdave"].should include({host:"0.0.0.0", port:"4000"}.to_json)
        end
        
        specify { redis.internal_hashes["players:playing"]["whatupdave"].should == "world1" }
      end
      
      context "requested world is not running" do
        context "a running worker is available" do
          before {
            redis.internal_hashes["workers:running"] = {"i-1234" => { instance_id:"i-1234", host:"0.0.0.0", started_at:Time.now.utc.to_s }.to_json}
            request.process({username:"whatupdave", user_id:"user1", world_id:"world1"}.to_json)
          }
        
          it "should request world start" do
            redis.internal_lists["worlds:requests:start"].should include({instance_id:"i-1234", world_id:"world1", min_heap_size:512, max_heap_size:2048}.to_json)
          end
        end
        
        context "a sleeping worker is available" do
          before {
            redis.internal_sets["workers:sleeping"] = ["i-1234"]
            request.process({username:"whatupdave", user_id:"user1", world_id:"world1"}.to_json)
          }
        
          it "should request worker start" do
            redis.internal_lists["workers:requests:start"].should include("i-1234")
          end
        end

        context "no worker is available" do
          before {
            request.process({username:"whatupdave", user_id:"user1", world_id:"world1"}.to_json)
          }
        
          it "should request worker create" do
            redis.internal_lists["workers:requests:create"].should have(1).request
          end
        end
      end
      
    end
  end
end