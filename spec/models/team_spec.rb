require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Team do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Team.create!(@valid_attributes)
  end
  
  it "should be able to have a start treasure, and populate current treasure form it." do
    t = Team.create!(:name =>"Team")

    
    t.start_treasure.should be_nil
    treasure = Treasure.create!(:name => "Gold")
    t.start_treasure = treasure
    t.start_treasure.should == treasure
    
    pending("setting currnet_treasure when start_treasure is set should work, but doesn't")
    
    t.current_treasure.should == treasure #This should work, but doesn't.
    t.save!
#    puts t.start_treasure.id
    
    #t = Team.find_by_name("Team")
    t.start_treasure.should_not be_nil
    t.current_treasure.should_not be_nil
    
  end
end
