require 'spec_helper'

module Prism
  describe PlayerMinutePlayedEvent do
    let(:request) { PlayerMinutePlayedEvent.new }
    let(:redis) { EM::FakeRedis }
    let(:user_oid) { BSON::ObjectId.new }
    
    before {
      PrismRedis.redis_factory = proc { EM::FakeRedis.new }
      redis.internal_hashes['usernames'] = {'whatupdave' => "#{user_oid}"}
      stub(request).mongo_connect.returns(@mongo = Object.new)
      stub(@mongo).collection('users').returns(@users = Object.new)
    }
    
    specify { PlayerMinutePlayedEvent.queue.should == "players:minute_played" }
    
    context "on minute played" do
      it "should add minute played to user" do
        Timecop.freeze(Time.now)
        mock(@users).find_and_modify({ 
                      query: {"_id"  => user_oid },
                      update: { 
                        '$push' => {'credit_history' => { 'created_at' => Time.now.utc, 'delta' => -1 } },
                        '$inc'  => {'credits' => -1, 'minutes_played' => 1 }}
                    }).returns({'credits' => 10})
                    
        request.process({username:"whatupdave", timestamp:Time.now.utc}.to_json)
        Timecop.return
      end
      
    end
  end
end