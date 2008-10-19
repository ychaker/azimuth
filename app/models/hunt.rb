class Hunt < ActiveRecord::Base
  include AASM
  
  validates_presence_of :name, :user_id
  
  has_many :treasures, :dependent => :destroy, :order => "position"
  
  belongs_to :user
  
  has_many :users
  
  aasm_column :state
  aasm_initial_state :being_planned
  
  aasm_state :being_planned
  aasm_state :hunting, :enter => :announce_starting_of_hunt
  aasm_state :complete, :enter => :announce_end_of_hunt  
  aasm_state :cancelled, :enter => :announce_hunt_cancelled 
  
  aasm_event :release_the_hounds do
    transitions :to => :hunting, :from => [:being_planned], :guard => Proc.new {|h| !(h.treasures.empty?) }
  end
  
  aasm_event :victory do 
    transitions :to => :complete, :from => [:hunting]
  end
  
  aasm_event :cancel do 
    transitions :to => :cancelled, :from => [:being_planned, :hunting]
  end
  
  
  def attempt_open_treasure_chest(discovery, user)
    current_treasure = user.current_treasure
    

    discovery.success = current_treasure.proximate?(discovery) if (discovery.lat)
    discovery.success = current_treasure.key == discovery.key if (discovery.key)
    
    if discovery.success?
      if current_treasure.last?
        user.current_treasure = user.hunt.treasures.first
      else
        user.current_treasure = user.hunt.treasures.find(current_treasure).lower_item
      end
      
      if user.current_treasure == user.start_treasure
        puts "YOU ARE ALL DONE"
        self.victory
        user.finish_hunt
      else
        user.send_next_clue
      end
    end
  end
  
  # calculate the total possible points in a hunt
  def total_points
    points = 0

    treasures.each {|treasure| points += treasure.points } 
    
    points
  end
  
  # bang out to the members that we are ready to go.
  def announce_starting_of_hunt
    users.each do |u| 
      puts "annoucing to #{u.login} with status #{u.state}"
      u.send_message("The Hunt: #{self.name} has Started, Good Luck!")
      # HACK HACK that we start with the second item if we have it to maintaint hunt_spec, otherwise the first.
      if self.treasures.size == 1
        u.start_hunt self.treasures[0] #self.treasures[rand(self.treasures.size)]
      else
        u.start_hunt self.treasures[1] #self.treasures[rand(self.treasures.size)]
      end
      u.send_next_clue
      u.save!
    end
  end
  
  def announce_end_of_hunt
    users.each do |u|
      puts "We've about to finish the hunt, user #{u.login} has state #{u.aasm_current_state}"
      u.finish_hunt
      puts "We've just finished the hunt, user #{u.login} has state #{u.aasm_current_state}"
      u.send_message "The Hunt has ended!"
      u.save!
    end
  end
  
  def announce_hunt_cancelled
    
    users.each { |u| u.send_message "The Hunt has been cancelled!"}
  end
    
end
