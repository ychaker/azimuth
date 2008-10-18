class Team < ActiveRecord::Base
  has_many :treasure_hunters
  
  has_many :team_entry
  has_many :hunts, :through => :team_entry
  
  belongs_to :start_treasure, :class_name => "Treasure" 
  belongs_to :current_treasure, :class_name => "Treasure"
  
  
  def score
    0
  end
  
  #def start_treasure=(st)
  #  self[:start_treasure]=st
  #  self[:current_treasure]=st
  #end
  
  
end
