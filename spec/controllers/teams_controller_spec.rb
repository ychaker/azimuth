require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TeamsController do

  def mock_team(stubs={})
    @mock_team ||= mock_model(Team, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all teams as @teams" do
      Team.should_receive(:find).with(:all).and_return([mock_team])
      get :index
      assigns[:teams].should == [mock_team]
    end

    describe "with mime type of xml" do
  
      it "should render all teams as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Team.should_receive(:find).with(:all).and_return(teams = mock("Array of Teams"))
        teams.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested team as @team" do
      Team.should_receive(:find).with("37").and_return(mock_team)
      get :show, :id => "37"
      assigns[:team].should equal(mock_team)
    end
    
    describe "with mime type of xml" do

      it "should render the requested team as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Team.should_receive(:find).with("37").and_return(mock_team)
        mock_team.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new team as @team" do
      Team.should_receive(:new).and_return(mock_team)
      get :new
      assigns[:team].should equal(mock_team)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested team as @team" do
      Team.should_receive(:find).with("37").and_return(mock_team)
      get :edit, :id => "37"
      assigns[:team].should equal(mock_team)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created team as @team" do
        Team.should_receive(:new).with({'these' => 'params'}).and_return(mock_team(:save => true))
        post :create, :team => {:these => 'params'}
        assigns(:team).should equal(mock_team)
      end

      it "should redirect to the created team" do
        Team.stub!(:new).and_return(mock_team(:save => true))
        post :create, :team => {}
        response.should redirect_to(team_url(mock_team))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved team as @team" do
        Team.stub!(:new).with({'these' => 'params'}).and_return(mock_team(:save => false))
        post :create, :team => {:these => 'params'}
        assigns(:team).should equal(mock_team)
      end

      it "should re-render the 'new' template" do
        Team.stub!(:new).and_return(mock_team(:save => false))
        post :create, :team => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested team" do
        Team.should_receive(:find).with("37").and_return(mock_team)
        mock_team.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :team => {:these => 'params'}
      end

      it "should expose the requested team as @team" do
        Team.stub!(:find).and_return(mock_team(:update_attributes => true))
        put :update, :id => "1"
        assigns(:team).should equal(mock_team)
      end

      it "should redirect to the team" do
        Team.stub!(:find).and_return(mock_team(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(team_url(mock_team))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested team" do
        Team.should_receive(:find).with("37").and_return(mock_team)
        mock_team.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :team => {:these => 'params'}
      end

      it "should expose the team as @team" do
        Team.stub!(:find).and_return(mock_team(:update_attributes => false))
        put :update, :id => "1"
        assigns(:team).should equal(mock_team)
      end

      it "should re-render the 'edit' template" do
        Team.stub!(:find).and_return(mock_team(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested team" do
      Team.should_receive(:find).with("37").and_return(mock_team)
      mock_team.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the teams list" do
      Team.stub!(:find).and_return(mock_team(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(teams_url)
    end

  end

end
