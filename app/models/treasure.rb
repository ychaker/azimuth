class Treasure < ActiveRecord::Base
  acts_as_mappable
  belongs_to :hunt
  acts_as_list :scope => :hunt_id
  
  validates_presence_of :name, :clue, :points
  validate :presence_of_position
  validate :presence_of_proximity
  
  def key_only?
    if self.lat == nil and self.lng == nil and self.key != nil
      true
    else
      false  
    end  
  end
  
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
    def presence_of_proximity
      unless :key
        errors.add( "Lat/Lng positioning requires a proximity in meters.")
      end
    end    
  
end
