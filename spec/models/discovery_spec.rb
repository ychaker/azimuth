require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Discovery do
  fixtures :users, :hunts
  before(:each) do
    @valid_attributes = {
      :treasure_id => "1",
      :lat => "1.5",
      :lng => "1.5",
      :key => "key",
      :hunt_id => hunts(:quentinshunt).id,
      :user_id => users(:quentin).id
    }
  end

  it "should create a new instance given valid attributes" do
    Discovery.create!(@valid_attributes)
  end
end
