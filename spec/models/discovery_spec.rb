require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Discovery do
  before(:each) do
    @valid_attributes = {
      :treasure_id => "1",
      :lat => "1.5",
      :lng => "1.5",
      :proof_of_life => "value for proof_of_life"
    }
  end

  it "should create a new instance given valid attributes" do
    Discovery.create!(@valid_attributes)
  end
end