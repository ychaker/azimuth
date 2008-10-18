require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/teams/edit.html.erb" do
  include TeamsHelper
  
  before(:each) do
    assigns[:team] = @team = stub_model(Team,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "should render edit form" do
    render "/teams/edit.html.erb"
    
    response.should have_tag("form[action=#{team_path(@team)}][method=post]") do
      with_tag('input#team_name[name=?]', "team[name]")
    end
  end
end


