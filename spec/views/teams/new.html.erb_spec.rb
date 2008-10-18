require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/teams/new.html.erb" do
  include TeamsHelper
  
  before(:each) do
    assigns[:team] = stub_model(Team,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "should render new form" do
    render "/teams/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", teams_path) do
      with_tag("input#team_name[name=?]", "team[name]")
    end
  end
end


