require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TreasuresController do

  def mock_treasure(stubs={})
    @mock_treasure ||= mock_model(Treasure, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all treasures as @treasures" do
      Treasure.should_receive(:find).with(:all).and_return([mock_treasure])
      get :index
      assigns[:treasures].should == [mock_treasure]
    end

    describe "with mime type of xml" do
  
      it "should render all treasures as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Treasure.should_receive(:find).with(:all).and_return(treasures = mock("Array of Treasures"))
        treasures.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested treasure as @treasure" do
      Treasure.should_receive(:find).with("37").and_return(mock_treasure)
      get :show, :id => "37"
      assigns[:treasure].should equal(mock_treasure)
    end
    
    describe "with mime type of xml" do

      it "should render the requested treasure as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Treasure.should_receive(:find).with("37").and_return(mock_treasure)
        mock_treasure.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new treasure as @treasure" do
      Treasure.should_receive(:new).and_return(mock_treasure)
      get :new
      assigns[:treasure].should equal(mock_treasure)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested treasure as @treasure" do
      Treasure.should_receive(:find).with("37").and_return(mock_treasure)
      get :edit, :id => "37"
      assigns[:treasure].should equal(mock_treasure)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created treasure as @treasure" do
        Treasure.should_receive(:new).with({'these' => 'params'}).and_return(mock_treasure(:save => true))
        post :create, :treasure => {:these => 'params'}
        assigns(:treasure).should equal(mock_treasure)
      end

      it "should redirect to the created treasure" do
        Treasure.stub!(:new).and_return(mock_treasure(:save => true))
        post :create, :treasure => {}
        response.should redirect_to(treasure_url(mock_treasure))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved treasure as @treasure" do
        Treasure.stub!(:new).with({'these' => 'params'}).and_return(mock_treasure(:save => false))
        post :create, :treasure => {:these => 'params'}
        assigns(:treasure).should equal(mock_treasure)
      end

      it "should re-render the 'new' template" do
        Treasure.stub!(:new).and_return(mock_treasure(:save => false))
        post :create, :treasure => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested treasure" do
        Treasure.should_receive(:find).with("37").and_return(mock_treasure)
        mock_treasure.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :treasure => {:these => 'params'}
      end

      it "should expose the requested treasure as @treasure" do
        Treasure.stub!(:find).and_return(mock_treasure(:update_attributes => true))
        put :update, :id => "1"
        assigns(:treasure).should equal(mock_treasure)
      end

      it "should redirect to the treasure" do
        Treasure.stub!(:find).and_return(mock_treasure(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(treasure_url(mock_treasure))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested treasure" do
        Treasure.should_receive(:find).with("37").and_return(mock_treasure)
        mock_treasure.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :treasure => {:these => 'params'}
      end

      it "should expose the treasure as @treasure" do
        Treasure.stub!(:find).and_return(mock_treasure(:update_attributes => false))
        put :update, :id => "1"
        assigns(:treasure).should equal(mock_treasure)
      end

      it "should re-render the 'edit' template" do
        Treasure.stub!(:find).and_return(mock_treasure(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested treasure" do
      Treasure.should_receive(:find).with("37").and_return(mock_treasure)
      mock_treasure.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the treasures list" do
      Treasure.stub!(:find).and_return(mock_treasure(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(treasures_url)
    end

  end

end
