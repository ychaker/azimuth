require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/discoveries/index.html.erb" do
  include DiscoveriesHelper
  
  before(:each) do
    assigns[:discoveries] = [
      stub_model(Discovery,
        :lat => "1.5",
        :lng => "1.5",
        :key => "key"
      ),
      stub_model(Discovery,
        :lat => "1.5",
        :lng => "1.5",
        :key => "key"
      )
    ]
  end

  it "should render list of discoveries" do
    render "/discoveries/index.html.erb"
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "key", 2)
  end
end

