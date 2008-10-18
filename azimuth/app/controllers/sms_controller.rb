class SmsController < ApplicationController
  # GET /sms
  # GET /sms.xml
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sms }
    end
  end
  
  # GET /sms/sendsms
  # GET /sms/sendsms.xml
  def sendsms

    render :text => "hi there sendsms"
    
    require 'net/http'
    require 'uri'

    HTTP.post_form URI.parse('https://api.zeepmobile.com/messaging/2008-07-14/send_message'),
                     { "q" => "ruby", "max" => "50" }
    
  end

  # GET /sms/1
  # GET /sms/1.xml
  def show
    @sms = Sms.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sms }
    end
  end

  # GET /sms/new
  # GET /sms/new.xml
  def new
    @sms = Sms.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sms }
    end
  end

  # GET /sms/1/edit
  def edit
    @sms = Sms.find(params[:id])
  end

  # POST /sms
  # POST /sms.xml
  def create
    @sms = Sms.new(params[:sms])

    respond_to do |format|
      if @sms.save
        flash[:notice] = 'Sms was successfully created.'
        format.html { redirect_to(@sms) }
        format.xml  { render :xml => @sms, :status => :created, :location => @sms }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sms.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sms/1
  # PUT /sms/1.xml
  def update
    @sms = Sms.find(params[:id])

    respond_to do |format|
      if @sms.update_attributes(params[:sms])
        flash[:notice] = 'Sms was successfully updated.'
        format.html { redirect_to(@sms) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sms.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sms/1
  # DELETE /sms/1.xml
  def destroy
    @sms = Sms.find(params[:id])
    @sms.destroy

    respond_to do |format|
      format.html { redirect_to(sms_url) }
      format.xml  { head :ok }
    end
  end
end
