require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/treasures/edit.html.erb" do
  include TreasuresHelper
  
  before(:each) do
    assigns[:treasure] = @treasure = stub_model(Treasure,
      :new_record? => false,
      :name => "value for name",
      :image => "value for image",
      :clue => "value for clue",
      :description => "value for description",
      :order => "1",
      :lat => "1.5",
      :lng => "1.5",
      :proximity => "1.5",
      :points => "1",
      :password => "value for password"
    )
  end

  it "should render edit form" do
    render "/treasures/edit.html.erb"
    
    response.should have_tag("form[action=#{treasure_path(@treasure)}][method=post]") do
      with_tag('input#treasure_name[name=?]', "treasure[name]")
      with_tag('input#treasure_image[name=?]', "treasure[image]")
      with_tag('input#treasure_clue[name=?]', "treasure[clue]")
      with_tag('input#treasure_description[name=?]', "treasure[description]")
      with_tag('input#treasure_order[name=?]', "treasure[order]")
      with_tag('input#treasure_lat[name=?]', "treasure[lat]")
      with_tag('input#treasure_lng[name=?]', "treasure[lng]")
      with_tag('input#treasure_proximity[name=?]', "treasure[proximity]")
      with_tag('input#treasure_points[name=?]', "treasure[points]")
      with_tag('input#treasure_password[name=?]', "treasure[password]")
    end
  end
end


