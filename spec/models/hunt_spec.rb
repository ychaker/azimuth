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

describe "Eric, Youssef and Ashish want to do a treasure hunt" do
  it "should be easy and fun" do
    #pending "Current flushing out"
    #create users, one own and two hunters
    eric = create_user({:name => "Eric", :login => "epugh"})
    youssef = create_user({:name => "Youssef", :login => "ychaker", :email => "ychaker@o19s.com"})
    ashish =  create_user({:name => "Ashish", :login => "atonse", :email => "atonse@gmail.com"})
    ashish.save!
    youssef.save!
    
    #create hunter team
    ya_team = Team.new(:name => "YA Team")
    ya_team.treasure_hunters << youssef
    ya_team.treasure_hunters << ashish
    ya_team.save
    ya_team.treasure_hunters.size.should == 2
    ya_team.aasm_current_state.should == :registering
    
    hunt = Hunt.create!(:name => "Eric's Hunt", :description => "A hunt around cville.")
    hunt.state.should == "being_planned"
    hunt.aasm_current_state.should == :being_planned
    
    
    eric.hunts << hunt
    hunt.pirate.should == eric
    
    first_treasure = Treasure.create!(:name => "Icarus Balls", :image => "http://farm4.static.flickr.com/3280/2950800503_8f00180b88_t.jpg", :points => 15, :lat => 52.1278, :lng => -81.5763, :proximity => 50, :clue => "Something Shiny")
    second_treasure = Treasure.create!(:name => "White Spot", :image => "http://www.foodhistory.com/foodnotes/road/va/ch/wh/01/03-image.jpg", :points => 25, :lat => 62.1278, :lng => -91.5763, :proximity => 30, :clue => "Best Burgers at 2 am")
    second_treasure.position.should == 2
    third_treasure = Treasure.create!(:name => "Rotunda", :image => "http://www.hankinsphotography.com/images/photo_full/MF_20050422_2_12.jpg", :points => 35, :lat => 70.1278, :lng => -85.5763, :proximity => 20, :clue => "Big Round, TJ built it!")
    
    [first_treasure, second_treasure, third_treasure].each {|t| hunt.treasures << t}
    
    hunt.total_points.should == 75
    hunt.treasures.size.should == 3
    hunt.save!
    

    hunt.teams << ya_team
    ya_team.hunt = hunt
    
    ya_team.start_hunt(second_treasure) 
    ya_team.current_treasure.should == second_treasure
    ya_team.save!
    ya_team.score.should == 0
    ya_team.aasm_current_state.should == :hunting
    
    ya_team.should == youssef.team
    
#    pending ("Working on state machine")
    hunt.release_the_hounds
    
    hunt.aasm_current_state.should == :hunting
     
    ya_team.current_treasure.name.should == "White Spot"
    
    #sms = Sms.new(:raw => "62.1288 -91.5773")
    #sms.parse
    ya_team.hunt.should == hunt
    
    d = Discovery.new(:treasure => ya_team.current_treasure, :lat =>62.1288, :lng => -91.5773, :hunt => hunt )
    ya_team.discoveries << d
    d.team.should == ya_team
    d.hunt.should == hunt
    d.team.current_hunt = hunt
    
    ya_team.save!

    ya_team.current_hunt.should == hunt
    d.team.current_hunt.should == hunt
    ya_team.discoveries.size.should == 1
    
    hunt.attempt_open_treasure_chest(d)
    
    d.save!
    d.success.should be_true
    d.team.current_treasure.should == third_treasure
    
    ya_team.reload
    ya_team.discoveries.size.should == 1
    youssef.team.discoveries.size.should == 1
    d.team.score.should == 25
    
    
    
    pending("still working")
        
    ashish.discover(:lat => 70.1118, :lng => -85.5753, :proof_of_life => "coords").should be_false
    ya_team.score.should == 25
    ya_team.current_treasure.should == third_treasure
    ashish.discover(:lat => 70.1268, :lng => -85.5753, :proof_of_life => "coords").should be_true
    ya_team.score.should == 60
    ya_team.current_treasure.should == first_treasure
    ashish.discover(:lat => 52.1278, :lng => -81.5763, :proof_of_life => "coords").should be_true
    hunt.state.should == "Done"
    
    youssef.team.score.should == 75
    ya_team.score.should == 75
  end
  
protected  
  def create_user( options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.register! if record.valid?
    record
  end  
end
