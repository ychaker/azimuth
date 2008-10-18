require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/teams/show.html.erb" do
  include TeamsHelper
  
  before(:each) do
    assigns[:team] = @team = stub_model(Team,
      :name => "value for name"
    )
  end

  it "should render attributes in <p>" do
    render "/teams/show.html.erb"
    response.should have_text(/value\ for\ name/)
  end
end

