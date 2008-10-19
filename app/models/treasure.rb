class Treasure < ActiveRecord::Base
  acts_as_mappable
  belongs_to :hunt
  acts_as_list :scope => :hunt_id
  
  validates_presence_of :name, :clue, :proximity, :points
  validate :presence_of_position
  
  def proximate?(discovery)
    
    # find distance in kilometers
    distance = Treasure.distance_between(self, discovery)
    
    distance_meters = distance * 1000
    return distance_meters <= self.proximity
  end
  
  private
    def presence_of_position
      unless (:lat and :lng) or :key
        errors.add( "Positioning is missing or invalid. Please add a Lat/Lng combo or a key!")
      end
    end
  
end
