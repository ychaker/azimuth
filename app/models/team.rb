class Team < ActiveRecord::Base
  has_many :treasure_hunters
  
  has_many :team_entry
  has_many :hunts, :through => :team_entry
  belongs_to :current_hunt, :class_name => "Hunt"  

  belongs_to :start_treasure, :class_name => "Treasure" 
  belongs_to :current_treasure, :class_name => "Treasure"
  
  has_many :discoveries
  
  
  def score
    points = 0
    discoveries_for_hunt = self.discoveries.select{ |discovery| discovery.hunt == self.current_hunt }
    
    puts "Discovery is for hunt is: #{discoveries_for_hunt.size}"
    successful_discoveries = discoveries_for_hunt.select{ |discovery| discovery.success? }
    puts "Success Discovery is for hunt is: #{successful_discoveries.size}"
    successful_discoveries.each {|discovery| points += discovery.treasure.points } 
    
    points
  end
  
  #def start_treasure=(st)
  #  self[:start_treasure]=st
  #  self[:current_treasure]=st
  #end
  
  
end
