class DiscoveriesController < ApplicationController
  # GET /discoveries
  # GET /discoveries.xml
  def index
    @discoveries = Discovery.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @discoveries }
    end
  end

  # GET /discoveries/1
  # GET /discoveries/1.xml
  def show
    @discovery = Discovery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @discovery }
    end
  end

  # GET /discoveries/new
  # GET /discoveries/new.xml
  def new
    @discovery = Discovery.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @discovery }
    end
  end

  # GET /discoveries/1/edit
  def edit
    @discovery = Discovery.find(params[:id])
  end

  # POST /discoveries
  # POST /discoveries.xml
  def create
    @discovery = Discovery.new(params[:discovery])

    respond_to do |format|
      if @discovery.save
        flash[:notice] = 'Discovery was successfully created.'
        format.html { redirect_to(@discovery) }
        format.xml  { render :xml => @discovery, :status => :created, :location => @discovery }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @discovery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /discoveries/1
  # PUT /discoveries/1.xml
  def update
    @discovery = Discovery.find(params[:id])

    respond_to do |format|
      if @discovery.update_attributes(params[:discovery])
        flash[:notice] = 'Discovery was successfully updated.'
        format.html { redirect_to(@discovery) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @discovery.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /discoveries/1
  # DELETE /discoveries/1.xml
  def destroy
    @discovery = Discovery.find(params[:id])
    @discovery.destroy

    respond_to do |format|
      format.html { redirect_to(discoveries_url) }
      format.xml  { head :ok }
    end
  end
end
