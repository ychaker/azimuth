class Treasure < ActiveRecord::Base
  acts_as_mappable
  belongs_to :hunt
  acts_as_list :scope => :hunt_id
  
  def proximate?(discovery)
    
    # find distance in kilometers
    distance = Treasure.distance_between(self, discovery)
    
    distance_meters = distance * 1000
    
    return distance_meters < self.proximity
    
    
  end
end
