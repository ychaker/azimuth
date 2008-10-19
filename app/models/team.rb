class Team < ActiveRecord::Base
  include AASM
  
  aasm_column :state
  aasm_initial_state :registering
  
  aasm_state :registering
  aasm_state :hunting#, :enter => :announce_start_of_hunt
  aasm_state :complete#, :enter => :announce_hunt_completed
  aasm_state :cancelled#, :enter => :announce_team_canceled
  
  has_many :treasure_hunters, :class_name => "User"
  
  belongs_to :hunt 

  belongs_to :start_treasure, :class_name => "Treasure" 
  belongs_to :current_treasure, :class_name => "Treasure"
  
  has_many :discoveries
  
  aasm_event :begin_hunt do
    transitions :to => :hunting, :from => [:registering]
  end
  
  aasm_event :finish_hunt do 
    transitions :to => :complete, :from => [:hunting]
  end
  
  aasm_event :cancel do 
    transitions :to => :cancelled, :from => [:registering, :hunting]
  end
  
  def score
    points = 0
    discoveries_for_hunt = self.discoveries.select{ |discovery| discovery.hunt == self.hunt }
    
    successful_discoveries = discoveries_for_hunt.select{ |discovery| discovery.success? }
    successful_discoveries.each {|discovery| points += discovery.treasure.points } 
    
    points
  end
  
  def start_hunt(treasure)
    self.start_treasure = treasure
    self.current_treasure = treasure
    unless self.treasure_hunters.blank? 
      self.begin_hunt
    end
    self.save
  end
  
  #def start_treasure=(st)
  #  self[:start_treasure]=st
  #  self[:current_treasure]=st
  #end
  
  
end
