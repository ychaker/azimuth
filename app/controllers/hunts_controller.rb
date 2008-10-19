class HuntsController < ApplicationController
  # GET /hunts
  # GET /hunts.xml
  def index
    @hunts = Hunt.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hunts }
    end
  end

  # GET /hunts/1
  # GET /hunts/1.xml
  def show
    @hunt = Hunt.find(params[:id])

    respond_to do |format|
      format.html {
        if request.xhr?
          render :partial => 'hunt_show', :locals => { :hunt => @hunt } if @hunt
        end
        
      }
      format.xml  { render :xml => @hunt }
    end
  end

  # GET /hunts/new
  # GET /hunts/new.xml
  def new
    @hunt = Hunt.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hunt }
    end
  end

  # GET /hunts/1/edit
  def edit
    @hunt = Hunt.find(params[:id])
  end

  # POST /hunts
  # POST /hunts.xml
  def create
    @hunt = Hunt.new(params[:hunt])

    respond_to do |format|
      if @hunt.save
        format.html { 
          if request.xhr?
            render :partial => 'hunt', :locals => { "hunt" => @hunt }
          else
            redirect_to(@hunt) 
          end
        }
        format.json  { render :json => @hunt, :status => :created, :location => @hunt }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @hunt.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def add_treasure
    @treasure = Treasure.new(params[:treasure])

    respond_to do |format|
      if @treasure.save!
        format.html { 
          if request.xhr? 
            render :partial => '/treasures/show', :locals => { :treasure => @treasure }
          else
            redirect_to(@treasure) 
          end
        }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @treasure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hunts/1
  # PUT /hunts/1.xml
  def update
    @hunt = Hunt.find(params[:id])
    
    if params['hunt_event']
      if params['hunt_event'] == "release_the_hounds"
        @hunt.release_the_hounds
      end
    end

    respond_to do |format|
      if @hunt.update_attributes(params[:hunt])
        # flash[:notice] = 'Hunt was successfully updated.'
        if @hunt.aasm_current_state == :being_planned
          flash[:error] = "Could not release the hounds, hunt wasn't ready"
          redirect_to(:controller => :hunters, :action => :awaiting_start)
        else
          format.html { 
            if request.xhr?
              render :text => "Released!"
            else
              redirect_to(@hunt) 
            end
          }
          format.xml  { head :ok }          
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hunt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hunts/1
  # DELETE /hunts/1.xml
  def destroy
    @hunt = Hunt.find(params[:id])
    @hunt.destroy

    respond_to do |format|
      format.html { redirect_to(hunts_url) }
      format.xml  { head :ok }
    end
  end
end
