require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/hunts/new.html.erb" do
  include HuntsHelper
  
  before(:each) do
    assigns[:hunt] = stub_model(Hunt,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "should render new form" do
    render "/hunts/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", hunts_path) do
      with_tag("input#hunt_name[name=?]", "hunt[name]")
    end
  end
end


