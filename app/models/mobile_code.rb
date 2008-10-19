class MobileCode < ActiveRecord::Base
  belongs_to :user
  belongs_to :hunt
  
  validates_presence_of :code
end
