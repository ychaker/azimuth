require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DiscoveriesController do

  def mock_discovery(stubs={})
    @mock_discovery ||= mock_model(Discovery, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all discoveries as @discoveries" do
      Discovery.should_receive(:find).with(:all).and_return([mock_discovery])
      get :index
      assigns[:discoveries].should == [mock_discovery]
    end

    describe "with mime type of xml" do
  
      it "should render all discoveries as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Discovery.should_receive(:find).with(:all).and_return(discoveries = mock("Array of Discoveries"))
        discoveries.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested discovery as @discovery" do
      Discovery.should_receive(:find).with("37").and_return(mock_discovery)
      get :show, :id => "37"
      assigns[:discovery].should equal(mock_discovery)
    end
    
    describe "with mime type of xml" do

      it "should render the requested discovery as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Discovery.should_receive(:find).with("37").and_return(mock_discovery)
        mock_discovery.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new discovery as @discovery" do
      Discovery.should_receive(:new).and_return(mock_discovery)
      get :new
      assigns[:discovery].should equal(mock_discovery)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested discovery as @discovery" do
      Discovery.should_receive(:find).with("37").and_return(mock_discovery)
      get :edit, :id => "37"
      assigns[:discovery].should equal(mock_discovery)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created discovery as @discovery" do
        Discovery.should_receive(:new).with({'these' => 'params'}).and_return(mock_discovery(:save => true))
        post :create, :discovery => {:these => 'params'}
        assigns(:discovery).should equal(mock_discovery)
      end

      it "should redirect to the created discovery" do
        Discovery.stub!(:new).and_return(mock_discovery(:save => true))
        post :create, :discovery => {}
        response.should redirect_to(discovery_url(mock_discovery))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved discovery as @discovery" do
        Discovery.stub!(:new).with({'these' => 'params'}).and_return(mock_discovery(:save => false))
        post :create, :discovery => {:these => 'params'}
        assigns(:discovery).should equal(mock_discovery)
      end

      it "should re-render the 'new' template" do
        Discovery.stub!(:new).and_return(mock_discovery(:save => false))
        post :create, :discovery => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested discovery" do
        Discovery.should_receive(:find).with("37").and_return(mock_discovery)
        mock_discovery.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :discovery => {:these => 'params'}
      end

      it "should expose the requested discovery as @discovery" do
        Discovery.stub!(:find).and_return(mock_discovery(:update_attributes => true))
        put :update, :id => "1"
        assigns(:discovery).should equal(mock_discovery)
      end

      it "should redirect to the discovery" do
        Discovery.stub!(:find).and_return(mock_discovery(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(discovery_url(mock_discovery))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested discovery" do
        Discovery.should_receive(:find).with("37").and_return(mock_discovery)
        mock_discovery.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :discovery => {:these => 'params'}
      end

      it "should expose the discovery as @discovery" do
        Discovery.stub!(:find).and_return(mock_discovery(:update_attributes => false))
        put :update, :id => "1"
        assigns(:discovery).should equal(mock_discovery)
      end

      it "should re-render the 'edit' template" do
        Discovery.stub!(:find).and_return(mock_discovery(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested discovery" do
      Discovery.should_receive(:find).with("37").and_return(mock_discovery)
      mock_discovery.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the discoveries list" do
      Discovery.stub!(:find).and_return(mock_discovery(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(discoveries_url)
    end

  end

end
