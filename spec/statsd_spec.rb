require 'spec_helper'

describe Statsd do
  it "can time" do
    Statsd.timing
  end
end