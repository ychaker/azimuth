class Hunt < ActiveRecord::Base
  include AASM
  
  has_many :treasures, :dependent => :destroy, :order => "position"
  
  belongs_to :user
  
  has_many :users
  
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
  
  
  def attempt_open_treasure_chest(discovery, user)
    current_treasure = user.current_treasure
    
    discovery.success = current_treasure.proximate?(discovery)
    
    
    if discovery.success?
      if current_treasure.last?
        user.current_treasure = user.hunt.treasures.first
      else
        user.current_treasure = user.hunt.treasures.find(current_treasure).lower_item
      end
      if user.current_treasure == user.start_treasure
        puts "YOU ARE ALL DONE"
        user.finish_hunt
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
