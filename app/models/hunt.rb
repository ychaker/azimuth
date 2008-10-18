class Hunt < ActiveRecord::Base
  has_many :treasures, :order => "position"
end
