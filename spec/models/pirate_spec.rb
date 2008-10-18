require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include AuthenticatedTestHelper

describe Pirate do
  
  fixtures :users
  before(:each) do

  end

  it "should create a pirate" do
    user = create_pirate
    user.should be_an_instance_of(Pirate)
    
    user.type.to_s.should == "Pirate"
  end
  
  it "should have the role of hunt_editor automatically" do
    
    pirate = create_pirate
    pirate.has_role?('hunt_editor').should be_true
  end
  
  it "should not have the role of admin automatically" do
    pirate = create_pirate
    pirate.has_role?('admin').should be_false
  end
  
protected
  def create_pirate(options = {})
    record = Pirate.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.register! if record.valid?
    record
  end  
end
