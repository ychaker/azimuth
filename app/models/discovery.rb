class Discovery < ActiveRecord::Base
  acts_as_mappable
  belongs_to :user
  belongs_to :treasure
  belongs_to :hunt
  
  
  # Good for find locations http://itouchmap.com/latlong.html
end
