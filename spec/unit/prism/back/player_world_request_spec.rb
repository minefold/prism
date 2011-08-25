require 'spec_helper'

def world_running world_id, options
  EM::FakeRedis.internal_hashes["worlds:running"] = {world_id => options.to_json }
end

def world_starting world_id
  EM::FakeRedis.internal_hashes["worlds:busy"] = {world_id => {state:'starting'}.to_json }
end

def worker_running instance_id, options = {}
  options = {instance_id:instance_id, host:"0.0.0.0", started_at:Time.now.utc.to_s}.merge(options)
  (EM::FakeRedis.internal_hashes["workers:running"] ||= {})[instance_id] = options.to_json
end

def worker_sleeping instance_id
  (EM::FakeRedis.internal_sets["workers:sleeping"] ||= []) << instance_id
end

module Prism
  describe PlayerWorldRequest do
    let(:redis) { EM::FakeRedis }
  
    context "player connects" do
      let(:request) { PlayerWorldRequest.new }
      
      def process_json data
        request.process data.to_json
      end
      
      context "requested world is running" do
        before {
          world_running "world1", instance_id:"i-1234", host:"0.0.0.0", port:"4000"
          process_json username:"whatupdave", user_id:"user1", world_id:"world1"
        }
        
        it "should connect player to world" do
          redis.internal_published["players:connection_request:whatupdave"].should include({host:"0.0.0.0", port:"4000"}.to_json)
        end
        
        specify { redis.internal_hashes["players:playing"]["whatupdave"].should == "world1" }
      end
      
      context "requested world is not running" do
        context "a running worker is available" do
          before {
            worker_running "i-1234"
            process_json username:"whatupdave", user_id:"user1", world_id:"world1"
          }
        
          it "should request world start" do
            redis.internal_lists["worlds:requests:start"].should include({instance_id:"i-1234", world_id:"world1", min_heap_size:512, max_heap_size:2048}.to_json)
          end
        end
        
        context "a sleeping worker is available" do
          before {
            worker_sleeping "i-1234"
            process_json username:"whatupdave", user_id:"user1", world_id:"world1"
          }
        
          it "should request worker start" do
            redis.internal_lists["workers:requests:start"].should include("i-1234")
          end
        end

        context "no worker is available" do
          before {
            process_json username:"whatupdave", user_id:"user1", world_id:"world1"
          }
        
          it "should request worker create" do
            redis.internal_lists["workers:requests:create"].should have(1).request
          end
        end
      end
      
      context "requested world is already starting" do
        before { 
          world_starting 'world7' 
          process_json username:"whatupdave", user_id:"user1", world_id:"world7"
        }
        
        it "should subscribe to world start" do
          redis.internal_subscriptions["worlds:requests:start:world7"].should have(1).subscribers
        end
        
      end
      
    end
    
    
    
  end
end