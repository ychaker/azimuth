class TreasuresController < ApplicationController
  # GET /treasures
  # GET /treasures.xml
  def index
    @treasures = Treasure.find(:all, :order => "position")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @treasures }
    end
  end

  # GET /treasures/1
  # GET /treasures/1.xml
  def show
    @treasure = Treasure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @treasure }
    end
  end

  # GET /treasures/new
  # GET /treasures/new.xml
  def new
    @treasure = Treasure.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @treasure }
    end
  end

  # GET /treasures/1/edit
  def edit
    @treasure = Treasure.find(params[:id])
  end

  # POST /treasures
  # POST /treasures.xml
  def create
    @treasure = Treasure.new(params[:treasure])

    respond_to do |format|
      if @treasure.save
        flash[:notice] = 'Treasure was successfully created.'
        format.html { redirect_to(@treasure) }
        format.xml  { render :xml => @treasure, :status => :created, :location => @treasure }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @treasure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /treasures/1
  # PUT /treasures/1.xml
  def update
    @treasure = Treasure.find(params[:id])

    respond_to do |format|
      if @treasure.update_attributes(params[:treasure])
        flash[:notice] = 'Treasure was successfully updated.'
        format.html { redirect_to(@treasure) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @treasure.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /treasures/1
  # DELETE /treasures/1.xml
  def destroy
    @treasure = Treasure.find(params[:id])
    @treasure.destroy

    respond_to do |format|
      format.html { redirect_to(treasures_url) }
      format.xml  { head :ok }
    end
  end
  
  # Move the mapping up in the list of priorities
  def move_up
    @treasure = Treasure.find_by_id(params[:id])
    @treasure.move_higher
    respond_to do |format|
      if @treasure.save
        flash[:notice] = 'Treasure was successfully updated.'
        format.html { redirect_to :action => :index}
      else
        format.html { render :action => "index" }
      end
    end
  end
  
  # Move the mapping down in the list of priorities
  def move_down
    @treasure = Treasure.find_by_id(params[:id])
    @treasure.move_lower
    respond_to do |format|
      if @treasure.save
        flash[:notice] = 'Treasure was successfully updated.'
        format.html { redirect_to :action => :index}
      else
        format.html { render :action => "index" }
      end
    end
  end
end
