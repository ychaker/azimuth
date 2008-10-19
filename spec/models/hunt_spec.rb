require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hunt do
  fixtures :hunts, :treasures
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    #Hunt.create!(@valid_attributes)
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
  
  it "should delete associated treasures" do
    hunt = hunts(:one)
    t_one = treasures(:one)
    t_two = treasures(:two)
    name = t_one.name
    hunt.treasures << t_one
    hunt.treasures << t_two
    hunt.save
    hunt.destroy
    Treasure.find_by_name(name).should be_nil
  end
  
  it "should return a true/false for the event open_treasure_chest depending if it works or now" do
    hunt = hunts(:one)
    hunt.aasm_current_state.should == :being_planned
    hunt.release_the_hounds
    hunt.aasm_current_state.should == :hunting
#    hunt.open_treasure_chest.should raise_error(RuntimeError)

#putser = Proc.new {|x| puts x}
#    begin
#    hunt.attemptopen_treasure_chest putser
#    rescue Exception => e
#      puts "resucing from error"
#      puts "e: #{e.class.to_s}"
#      puts "ex text: #{e.to_s}"
#    end
    
  end
end

describe "Eric and Ashish want to do a treasure hunt" do
  it "should be easy and fun" do
    #pending "Current flushing out"
    #create users, one own and two hunters
    eric = create_user({:name => "Eric", :login => "epugh"})
    ashish =  create_user({:name => "Ashish", :login => "atonse", :email => "atonse@gmail.com"})
    ashish.activate
    ashish.save!
    
    hunt = Hunt.create!(:name => "Eric's Hunt", :description => "A hunt around cville.", :user_id => eric.id)
    hunt.state.should == "being_planned"
    hunt.aasm_current_state.should == :being_planned
    
    
    eric.hunts << hunt
    hunt.user.should == eric
    
    eric.hunts.size.should == 1
    
    first_treasure = Treasure.create!(:name => "Icarus Balls", :image => "http://farm4.static.flickr.com/3280/2950800503_8f00180b88_t.jpg", :points => 15, :lat => 70.2278, :lng => -85.5865, :proximity => 50, :clue => "Something Shiny", :description => "test")
    second_treasure = Treasure.create!(:name => "White Spot", :image => "http://www.foodhistory.com/foodnotes/road/va/ch/wh/01/03-image.jpg", :points => 25, :lat => 62.1278, :lng => -91.5763, :proximity => 30, :clue => "Best Burgers at 2 am", :description => "test")
    second_treasure.position.should == 2
    third_treasure = Treasure.create!(:name => "Rotunda", :image => "http://www.hankinsphotography.com/images/photo_full/MF_20050422_2_12.jpg", :points => 35, :lat => 70.1278, :lng => -85.5763, :proximity => 20, :clue => "Big Round, TJ built it!", :description => "test")
    
    [first_treasure, second_treasure, third_treasure].each {|t| hunt.treasures << t}
    
    hunt.total_points.should == 75
    hunt.treasures.size.should == 3
    hunt.save!
    

    
    
    ashish.join_hunt(hunt)
    ashish.hunt.should == hunt
    ashish.aasm_current_state.should == :hunt_registering
    ashish.save!
    

  
    hunt.release_the_hounds
    hunt.aasm_current_state.should == :hunting

    ashish.reload
    ashish.current_treasure.should == second_treasure
    ashish.save!
    ashish.score.should == 0
    ashish.aasm_current_state.should == :hunt_hunting
    

     
    ashish.current_treasure.name.should == "White Spot"
    
    #sms = Sms.new(:raw => "62.1288 -91.5773")
    #sms.parse
    ashish.hunt.should == hunt
    
    d = Discovery.new(:treasure => ashish.current_treasure, :lat => 62.1278, :lng => -91.5763, :hunt => hunt, :user_id => ashish.id)
    ashish.discoveries << d
    d.save
    d.user.should == ashish
    d.hunt.should == hunt
    d.user.hunt.should == hunt
    
    ashish.save!

    ashish.hunt.should == hunt
    d.user.hunt.should == hunt
    ashish.discoveries.size.should == 1
    
    hunt.attempt_open_treasure_chest(d, ashish)
    
    d.save!
    d.success.should be_true
    ashish.save!
    
    ashish.current_treasure.should == third_treasure
    
    ashish.discoveries.size.should == 1
    ashish.score.should == 25
    
    
    
    failed_discovery = Discovery.new(:treasure => ashish.current_treasure, :lat => 70.1118, :lng => -85.5753, :user_id => ashish.id)
    ashish.discoveries << failed_discovery
    failed_discovery.save
    
    hunt.attempt_open_treasure_chest(failed_discovery, ashish)
    
    failed_discovery.success.should be_false
    
    ashish.score.should == 25
    ashish.current_treasure.should == third_treasure
    
    next_discovery = Discovery.new(:treasure => ashish.current_treasure, :lat => 70.1278, :lng => -85.5765, :hunt => hunt, :user_id => ashish.id)
    ashish.discoveries << next_discovery
    next_discovery.save
    
    hunt.attempt_open_treasure_chest(next_discovery, ashish)
    ashish.aasm_current_state.should == :hunt_hunting
    next_discovery.success.should be_true
    
    ashish.score.should == 60
    ashish.current_treasure.should == first_treasure
    
    
    #pending("still working")
    last_discovery = Discovery.new(:treasure => ashish.current_treasure, :lat => 70.2278, :lng => -85.5864, :hunt => hunt, :user_id => ashish.id)
    ashish.discoveries << last_discovery
    last_discovery.save
    ashish.discoveries.size.should == 4
    
    hunt.attempt_open_treasure_chest(last_discovery, ashish)
    
    last_discovery.success.should be_true
    
    hunt.aasm_current_state.should == :complete
    

    ashish.score.should == 75
    ashish.current_treasure.should == second_treasure
    
#    hunt.victory
    ashish.aasm_current_state.should == :active
  end
  
protected  
  def create_user( options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.register! if record.valid?
    record
  end  
end
