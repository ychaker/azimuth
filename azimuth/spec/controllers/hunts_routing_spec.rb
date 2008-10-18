require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HuntsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "hunts", :action => "index").should == "/hunts"
    end
  
    it "should map #new" do
      route_for(:controller => "hunts", :action => "new").should == "/hunts/new"
    end
  
    it "should map #show" do
      route_for(:controller => "hunts", :action => "show", :id => 1).should == "/hunts/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "hunts", :action => "edit", :id => 1).should == "/hunts/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "hunts", :action => "update", :id => 1).should == "/hunts/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "hunts", :action => "destroy", :id => 1).should == "/hunts/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/hunts").should == {:controller => "hunts", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/hunts/new").should == {:controller => "hunts", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/hunts").should == {:controller => "hunts", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/hunts/1").should == {:controller => "hunts", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/hunts/1/edit").should == {:controller => "hunts", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/hunts/1").should == {:controller => "hunts", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/hunts/1").should == {:controller => "hunts", :action => "destroy", :id => "1"}
    end
  end
end
