require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Treasure do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :image => "value for image",
      :clue => "value for clue",
      :description => "value for description",
      :hunt_id => "1",
      :position => "1",
      :lat => "1.5",
      :lng => "1.5",
      :proximity => "1.5",
      :points => "1",
      :password => "value for password"
    }
  end

  it "should create a new instance given valid attributes" do
    Treasure.create!(@valid_attributes)
  end
end
