class Treasure < ActiveRecord::Base
  belongs_to :hunt
  acts_as_list :scope => :hunt_id
end
