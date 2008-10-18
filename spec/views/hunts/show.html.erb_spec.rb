require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/hunts/show.html.erb" do
  include HuntsHelper
  
  before(:each) do
    assigns[:hunt] = @hunt = stub_model(Hunt,
      :name => "value for name"
    )
  end

  it "should render attributes in <p>" do
    render "/hunts/show.html.erb"
    response.should have_text(/value\ for\ name/)
  end
end

