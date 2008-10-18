require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/hunts/edit.html.erb" do
  include HuntsHelper
  
  before(:each) do
    assigns[:hunt] = @hunt = stub_model(Hunt,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "should render edit form" do
    render "/hunts/edit.html.erb"
    
    response.should have_tag("form[action=#{hunt_path(@hunt)}][method=post]") do
      with_tag('input#hunt_name[name=?]', "hunt[name]")
    end
  end
end


