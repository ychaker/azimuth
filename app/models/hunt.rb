class Hunt < ActiveRecord::Base
  include AASM
  
  has_many :treasures, :dependent => :destroy, :order => "position"
  
  belongs_to :pirate
  
  has_many :team_entry
  has_many :teams, :through => :team_entry
  
  aasm_column :state
  aasm_initial_state :being_planned
  
  aasm_state :being_planned
  aasm_state :hunting
  aasm_state :complete
  aasm_state :cancelled
  
  aasm_event :release_the_hounds do
    transitions :to => :hunting, :from => [:being_planned]
  end
  
  aasm_event :victory do 
    transitions :to => :complete, :from => [:hunting]
  end
  
  aasm_event :cancel do 
    transitions :to => :cancelled, :from => [:being_planned, :hunting]
  end
  
  
  def attempt_open_treasure_chest(discovery)
    discovery.success = true
    
    if discovery.success?
      if discovery.team.current_treasure.last?
        discovery.team.current_treasure = discovery.team.current_hunt.treasures.first
      else
        discovery.team.current_treasure = discovery.team.current_hunt.treasures.find(discovery.team.current_treasure).lower_item
      end
    
      if discovery.team.current_treasure == discovery.team.start_treasure
        puts "YOU ARE ALL DONE"
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
