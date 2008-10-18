require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TreasuresController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "treasures", :action => "index").should == "/treasures"
    end
  
    it "should map #new" do
      route_for(:controller => "treasures", :action => "new").should == "/treasures/new"
    end
  
    it "should map #show" do
      route_for(:controller => "treasures", :action => "show", :id => 1).should == "/treasures/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "treasures", :action => "edit", :id => 1).should == "/treasures/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "treasures", :action => "update", :id => 1).should == "/treasures/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "treasures", :action => "destroy", :id => 1).should == "/treasures/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/treasures").should == {:controller => "treasures", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/treasures/new").should == {:controller => "treasures", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/treasures").should == {:controller => "treasures", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/treasures/1").should == {:controller => "treasures", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/treasures/1/edit").should == {:controller => "treasures", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/treasures/1").should == {:controller => "treasures", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/treasures/1").should == {:controller => "treasures", :action => "destroy", :id => "1"}
    end
  end
end
