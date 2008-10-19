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
      :key => "value for key"
    }
  end

  it "should create a new instance given valid attributes" do
    Treasure.create!(@valid_attributes)
  end
  
  it "should be able to detect if a Discovery took place within a radius of a Treasure" do
    t = Treasure.create!(:name => "Cool Treasure", :clue => "where Eric Pugh Lives", :lat => 38.012331, :lng => -78.514305, :proximity => 1000)
    
    d = Discovery.create!(:lat => 38.012411, :lng => -78.515275)
    
    distance = Treasure.distance_between(d, t)
    
    t.proximate?(d).should be_true
    
    rotunda = Discovery.create!(:lat => 38.035581, :lng => -78.503548)
    
    t.proximate?(rotunda).should be_false
    
  end
  
  it "should be able to detect if a Discovery took place within a radius of a Treasure part deux" do
    t = Treasure.create!(:name => "Cool Treasure", :clue => "where Eric Pugh Lives", :lat => 70.2278, :lng => -85.5864, :proximity => 1000)
    
    d = Discovery.create!(:lat => 70.2278, :lng => -85.5864)
    
    distance = Treasure.distance_between(d, t)
    
    t.proximate?(d).should be_true
    
  end
end
