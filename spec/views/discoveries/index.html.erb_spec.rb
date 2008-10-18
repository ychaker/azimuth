require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/discoveries/index.html.erb" do
  include DiscoveriesHelper
  
  before(:each) do
    assigns[:discoveries] = [
      stub_model(Discovery,
        :lat => "1.5",
        :lng => "1.5",
        :proof_of_life => "value for proof_of_life"
      ),
      stub_model(Discovery,
        :lat => "1.5",
        :lng => "1.5",
        :proof_of_life => "value for proof_of_life"
      )
    ]
  end

  it "should render list of discoveries" do
    render "/discoveries/index.html.erb"
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "value for proof_of_life", 2)
  end
end

