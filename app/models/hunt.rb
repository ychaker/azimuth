class Hunt < ActiveRecord::Base
  has_many :treasures, :dependent => :destroy, :order => "position"
  
  belongs_to :pirate
  
  has_many :team_entry
  has_many :teams, :through => :team_entry
  
  # calculate the total possible points in a hunt
  def total_points
    points = 0

    treasures.each {|treasure| points += treasure.points } 
    
    points
  end
    
end
