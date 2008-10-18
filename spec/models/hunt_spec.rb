require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hunt do
  fixtures :hunts, :treasures
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Hunt.create!(@valid_attributes)
  end
  
  it "should calculate the total possible points" do
    hunt = hunts(:one)
    t_one = treasures(:one)
    t_two = treasures(:two)
    hunt.treasures << t_one
    hunt.treasures << t_two
    hunt.save
    points = hunt.total_points
    points.should == t_two.points + t_one.points
  end
end
