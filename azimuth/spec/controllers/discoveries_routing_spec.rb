require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DiscoveriesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "discoveries", :action => "index").should == "/discoveries"
    end
  
    it "should map #new" do
      route_for(:controller => "discoveries", :action => "new").should == "/discoveries/new"
    end
  
    it "should map #show" do
      route_for(:controller => "discoveries", :action => "show", :id => 1).should == "/discoveries/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "discoveries", :action => "edit", :id => 1).should == "/discoveries/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "discoveries", :action => "update", :id => 1).should == "/discoveries/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "discoveries", :action => "destroy", :id => 1).should == "/discoveries/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/discoveries").should == {:controller => "discoveries", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/discoveries/new").should == {:controller => "discoveries", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/discoveries").should == {:controller => "discoveries", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/discoveries/1").should == {:controller => "discoveries", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/discoveries/1/edit").should == {:controller => "discoveries", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/discoveries/1").should == {:controller => "discoveries", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/discoveries/1").should == {:controller => "discoveries", :action => "destroy", :id => "1"}
    end
  end
end
