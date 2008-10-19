class TeamEntry < ActiveRecord::Base

  belongs_to :hunt
  belongs_to :team
  
end
