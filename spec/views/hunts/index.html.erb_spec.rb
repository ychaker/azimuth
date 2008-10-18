require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/hunts/index.html.erb" do
  include HuntsHelper
  
  before(:each) do
    assigns[:hunts] = [
      stub_model(Hunt,
        :name => "value for name"
      ),
      stub_model(Hunt,
        :name => "value for name"
      )
    ]
  end

  it "should render list of hunts" do
    render "/hunts/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
  end
end

