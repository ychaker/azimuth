require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/treasures/index.html.erb" do
  include TreasuresHelper
  
  before(:each) do
    assigns[:treasures] = [
      stub_model(Treasure,
        :name => "value for name",
        :image => "value for image",
        :clue => "value for clue",
        :description => "value for description",
        :position => "1",
        :lat => "1.5",
        :lng => "1.5",
        :proximity => "1.5",
        :points => "1",
        :password => "value for password"
      ),
      stub_model(Treasure,
        :name => "value for name",
        :image => "value for image",
        :clue => "value for clue",
        :description => "value for description",
        :position => "1",
        :lat => "1.5",
        :lng => "1.5",
        :proximity => "1.5",
        :points => "1",
        :password => "value for password"
      )
    ]
  end

  it "should render list of treasures" do
    render "/treasures/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for image", 2)
    response.should have_tag("tr>td", "value for clue", 2)
    response.should have_tag("tr>td", "value for description", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "value for password", 2)
  end
end

