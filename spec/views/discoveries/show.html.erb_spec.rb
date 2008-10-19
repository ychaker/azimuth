require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/discoveries/show.html.erb" do
  include DiscoveriesHelper
  
  before(:each) do
    assigns[:discovery] = @discovery = stub_model(Discovery,
      :lat => "1.5",
      :lng => "1.5",
      :key => "key"
    )
  end

  it "should render attributes in <p>" do
    render "/discoveries/show.html.erb"
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
    response.should have_text(/key/)
  end
end

