require 'spec_helper'

module Prism
  describe PlayerConnectionRequest do
    include EM::Spec
  
    describe '#run' do
      context 'user connecting with target host' do
        
        before do
          User.should_receive(:find_by_slug).with('whatupdave').and_yield(User.new({}))
          
          World.should_receive(:find_by_slug).with('whatupdave', 'minebnb')
        end
        
        it "should find world" do
          request = PlayerConnectionRequest.new
          request.instance_variable_set(:'@username', 'whatupdave')
          request.instance_variable_set(:'@target_host', 'minebnb.chrislloyd.fold.to')
          
          
        
          request.run
          done
        end
      end
    end
  end
end