require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/discoveries/edit.html.erb" do
  include DiscoveriesHelper
  
  before(:each) do
    assigns[:discovery] = @discovery = stub_model(Discovery,
      :new_record? => false,
      :lat => "1.5",
      :lng => "1.5",
      :proof_of_life => "value for proof_of_life"
    )
  end

  it "should render edit form" do
    render "/discoveries/edit.html.erb"
    
    response.should have_tag("form[action=#{discovery_path(@discovery)}][method=post]") do
      with_tag('input#discovery_lat[name=?]', "discovery[lat]")
      with_tag('input#discovery_lng[name=?]', "discovery[lng]")
      with_tag('input#discovery_proof_of_life[name=?]', "discovery[proof_of_life]")
    end
  end
end


