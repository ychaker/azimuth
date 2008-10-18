require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper

describe TreasureHunter do
  
  fixtures :users
  before(:each) do

  end

  it "should create a pirate" do
    user = create_treasure_hunter
    user.should be_an_instance_of(TreasureHunter)
    
    user.type.to_s.should == "TreasureHunter"
  end
  
  it "should not have the role of hunt_editor automatically" do
    
    hunter = create_treasure_hunter
    hunter.has_role?('hunt_editor').should be_false
  end
  
  it "should not have the role of admin automatically" do
    hunter = create_treasure_hunter
    hunter.has_role?('admin').should be_false
  end
  
  it "should have the role of treasure_hunter automatically" do
    hunter = create_treasure_hunter
    hunter.has_role?('treasure_hunter').should be_true
  end  
  
protected
  def create_treasure_hunter(options = {})
    record = TreasureHunter.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.register! if record.valid?
    record
  end  
end
