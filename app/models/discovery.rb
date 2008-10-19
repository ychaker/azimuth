class Discovery < ActiveRecord::Base
  belongs_to :team
  belongs_to :treasure
  belongs_to :hunt
end
