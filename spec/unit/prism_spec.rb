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
      redis.lists["players:requesting_connection"].should include('whatupdave')
    end
    
    it "should subscribe to request result" do
      redis.subscriptions["players:requesting_connection_result:whatupdave"].should have(1).subscribers
    end
    
    context "when running world result received" do
      before { redis.publish "players:requesting_connection_result:whatupdave", { status:'world_running', host:"0.0.0.0", port:"4001"}.to_json }
      
      it "should proxy client"
    end
  end
end