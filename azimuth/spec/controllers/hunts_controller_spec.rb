require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HuntsController do

  def mock_hunt(stubs={})
    @mock_hunt ||= mock_model(Hunt, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all hunts as @hunts" do
      Hunt.should_receive(:find).with(:all).and_return([mock_hunt])
      get :index
      assigns[:hunts].should == [mock_hunt]
    end

    describe "with mime type of xml" do
  
      it "should render all hunts as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Hunt.should_receive(:find).with(:all).and_return(hunts = mock("Array of Hunts"))
        hunts.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested hunt as @hunt" do
      Hunt.should_receive(:find).with("37").and_return(mock_hunt)
      get :show, :id => "37"
      assigns[:hunt].should equal(mock_hunt)
    end
    
    describe "with mime type of xml" do

      it "should render the requested hunt as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Hunt.should_receive(:find).with("37").and_return(mock_hunt)
        mock_hunt.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new hunt as @hunt" do
      Hunt.should_receive(:new).and_return(mock_hunt)
      get :new
      assigns[:hunt].should equal(mock_hunt)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested hunt as @hunt" do
      Hunt.should_receive(:find).with("37").and_return(mock_hunt)
      get :edit, :id => "37"
      assigns[:hunt].should equal(mock_hunt)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created hunt as @hunt" do
        Hunt.should_receive(:new).with({'these' => 'params'}).and_return(mock_hunt(:save => true))
        post :create, :hunt => {:these => 'params'}
        assigns(:hunt).should equal(mock_hunt)
      end

      it "should redirect to the created hunt" do
        Hunt.stub!(:new).and_return(mock_hunt(:save => true))
        post :create, :hunt => {}
        response.should redirect_to(hunt_url(mock_hunt))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved hunt as @hunt" do
        Hunt.stub!(:new).with({'these' => 'params'}).and_return(mock_hunt(:save => false))
        post :create, :hunt => {:these => 'params'}
        assigns(:hunt).should equal(mock_hunt)
      end

      it "should re-render the 'new' template" do
        Hunt.stub!(:new).and_return(mock_hunt(:save => false))
        post :create, :hunt => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested hunt" do
        Hunt.should_receive(:find).with("37").and_return(mock_hunt)
        mock_hunt.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :hunt => {:these => 'params'}
      end

      it "should expose the requested hunt as @hunt" do
        Hunt.stub!(:find).and_return(mock_hunt(:update_attributes => true))
        put :update, :id => "1"
        assigns(:hunt).should equal(mock_hunt)
      end

      it "should redirect to the hunt" do
        Hunt.stub!(:find).and_return(mock_hunt(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(hunt_url(mock_hunt))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested hunt" do
        Hunt.should_receive(:find).with("37").and_return(mock_hunt)
        mock_hunt.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :hunt => {:these => 'params'}
      end

      it "should expose the hunt as @hunt" do
        Hunt.stub!(:find).and_return(mock_hunt(:update_attributes => false))
        put :update, :id => "1"
        assigns(:hunt).should equal(mock_hunt)
      end

      it "should re-render the 'edit' template" do
        Hunt.stub!(:find).and_return(mock_hunt(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested hunt" do
      Hunt.should_receive(:find).with("37").and_return(mock_hunt)
      mock_hunt.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the hunts list" do
      Hunt.stub!(:find).and_return(mock_hunt(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(hunts_url)
    end

  end

end
