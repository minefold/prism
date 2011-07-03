require 'spec_helper'
require 'sauron'

describe Sauron do
  context "world states on init" do
    it "is empty with no workers" do
      s = Sauron.new
    
      s.workers.count.should == 0
    end
  end
end