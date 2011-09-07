require 'spec_helper'

module Prism
  describe Client do
    include EM::Spec
    
    before do
      PrismRedis.redis_factory = proc { EM::FakeRedis.new }
      @connection = EM::FakeConnection.new Prism::Client
    end
  
    context "no data has been sent" do
      context "receives valid username packet" do
        before { @connection.fake_recv_auth 'whatupdave' }
      
        subject { @connection.handler }
      
        its(:username) { should == 'whatupdave'; done }
      end
    
      # context "bad auth packet sent" do
      #   before { @connection.fake_bad_auth }
      #   it "should disconnect" do
      #     @connection.connection_open.should be_false
      #     done
      #   end
      # end
    end
    #   
    # context "when username has been set" do
    #   before { @connection.fake_recv_auth 'whatupdave' }
    # 
    #   it "should push user onto connecting queue" do
    #     redis.internal_lists["players:connection_request"].should include('whatupdave')
    #     done
    #   end
    # 
    #   it "should subscribe to request result" do
    #     redis.internal_subscriptions["players:connection_request:whatupdave"].should have(1).subscribers
    #     done
    #   end
    # end
  end
end