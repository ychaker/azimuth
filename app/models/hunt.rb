class Hunt < ActiveRecord::Base
  has_many :treasures, :dependent => :destroy, :order => "position"
  
  # caluculate the total possible points in a hunt
  def total_points
    points = 0
    if self.treasures.blank?
      return 0
    else
      treasures.each {
        |treasure|
        points += treasure.points
      }
    end
    points
  end
    
end
