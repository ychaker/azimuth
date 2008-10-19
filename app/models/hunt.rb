class Hunt < ActiveRecord::Base
  include AASM
  
  has_many :treasures, :dependent => :destroy, :order => "position"
  
  belongs_to :user
  
  has_many :teams
  
  aasm_column :state
  aasm_initial_state :being_planned
  
  aasm_state :being_planned
  aasm_state :hunting#, :enter => :send_initial_txt_messages
  aasm_state :complete#, :enter => :announce_end_of_hunt  
  aasm_state :cancelled#, :enter => :announce_hunt_canceled 
  
  aasm_event :release_the_hounds do
    transitions :to => :hunting, :from => [:being_planned]
  end
  
  aasm_event :victory do 
    transitions :to => :complete, :from => [:hunting]
  end
  
  aasm_event :cancel do 
    transitions :to => :cancelled, :from => [:being_planned, :hunting]
  end
  
  
  def attempt_open_treasure_chest(discovery, team)
    discovery.success = discovery.team.current_treasure.proximate?(discovery)
    discovery.save
    
    #team = discovery.team
    current_treasure = team.current_treasure
    
    if discovery.success?
      if current_treasure.last?
        team.current_treasure = team.hunt.treasures.first
      else
        puts team.hunt.treasures.find(current_treasure).lower_item.inspect
        team.current_treasure = team.hunt.treasures.find(current_treasure).lower_item
      end
      puts team.inspect
      if team.current_treasure == team.start_treasure
        puts "YOU ARE ALL DONE"
        team.finish_hunt
      end
    end
  end
  
  # calculate the total possible points in a hunt
  def total_points
    points = 0

    treasures.each {|treasure| points += treasure.points } 
    
    points
  end
    
end
