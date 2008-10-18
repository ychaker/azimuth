require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/treasures/show.html.erb" do
  include TreasuresHelper
  
  before(:each) do
    assigns[:treasure] = @treasure = stub_model(Treasure,
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

  it "should render attributes in <p>" do
    render "/treasures/show.html.erb"
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ image/)
    response.should have_text(/value\ for\ clue/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/1/)
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ password/)
  end
end

