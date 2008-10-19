require 'rake'

namespace :data do
  desc "Creates treasures" 
  task :create do
    hunt = Hunt.create(:name => "Weekends in Cville")
    hunt.treasures << Treasure.create(:name => "Icarus Balls", :image => "http://farm4.static.flickr.com/3280/2950800503_8f00180b88_t.jpg", :points => 15, :lat => 52.1278, :lng => -81.5763, :proximity => 50, :clue => "Something Shiny")
    hunt.treasures << Treasure.create(:name => "White Spot", :image => "http://www.foodhistory.com/foodnotes/road/va/ch/wh/01/03-image.jpg", :points => 25, :lat => 62.1278, :lng => -91.5763, :proximity => 30, :clue => "Best Burgers at 2 am")
    hunt.treasures << Treasure.create(:name => "Rotunda", :image => "http://www.hankinsphotography.com/images/photo_full/MF_20050422_2_12.jpg", :points => 35, :lat => 70.1278, :lng => -85.5763, :proximity => 20, :clue => "Big Round, TJ built it!")
  end
end