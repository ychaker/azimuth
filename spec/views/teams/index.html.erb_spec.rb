require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/teams/index.html.erb" do
  include TeamsHelper
  
  before(:each) do
    assigns[:teams] = [
      stub_model(Team,
        :name => "value for name"
      ),
      stub_model(Team,
        :name => "value for name"
      )
    ]
  end

  it "should render list of teams" do
    render "/teams/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
  end
end

