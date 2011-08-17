require 'spec_helper'

describe Prism::Client do
  before :each do
    @connection = Prism::FakeConnection.new
    EM::FakeRedis.reset
  end
  
  context "no data has been sent" do
    context "receives valid username packet" do
      before { @connection.fake_recv_auth 'whatupdave' }
      
      it "extracts username" do
        @connection.handler.username.should == 'whatupdave'
      end
    end
    
    context "bad auth packet sent" do
      before { @connection.fake_bad_auth }
      it "should disconnect" do
        @connection.connection_open.should be_false
      end
    end
  end
  
  context "when username has been set" do
    before(:each) { @connection.fake_recv_auth 'whatupdave' }
    
    it "should push user onto connecting queue" do
      EM::FakeRedis.lists["players:requesting_world"].should include('whatupdave')
    end
    
    it "should subscribe to request result" do
      EM::FakeRedis.subscriptions["players:requesting_world_result:whatupdave"].should have(1).subscribers
    end
  end
end