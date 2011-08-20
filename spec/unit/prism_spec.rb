require 'spec_helper'

describe Prism::Client do
  let(:redis) { EM::FakeRedis }

  before :each do
    @connection = EM::FakeConnection.new Prism::Client
    redis.reset
  end
  
  context "no data has been sent" do
    context "receives valid username packet" do
      before { @connection.fake_recv_auth 'whatupdave' }
      
      subject { @connection.handler }
      
      its(:username) { should == 'whatupdave' }
    end
    
    context "bad auth packet sent" do
      before { @connection.fake_bad_auth }
      it "should disconnect" do
        @connection.connection_open.should be_false
      end
    end
  end
  
  context "when username has been set" do
    before { @connection.fake_recv_auth 'whatupdave' }
    
    it "should push user onto connecting queue" do
      redis.internal_lists["players:connection_request"].should include('whatupdave')
    end
    
    it "should subscribe to request result" do
      redis.internal_subscriptions["players:connection_request:whatupdave"].should have(1).subscribers
    end
  end
end