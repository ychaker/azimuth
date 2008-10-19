class SmsController < ApplicationController
  protect_from_forgery :secret => 'b0a876313f3f9195e9bd01473bc5cd06', :except => :incoming
    
  @username_entered = false
  @zeep_response = ""
  
  # GET /sms
  # GET /sms.xml
  def index
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sms }
    end
  end

  # GET /sms/testloop
  # GET /sms/testloop.xml
  def testloop
    
  end
  
  # GET /sms/enterusername
  # GET /sms/enterusername.xml
  def enterusername
    @username_entered = true
    session[:zeepusername] = params[:sms][:username]    
    render :action => "testloop"
  end
  
  # GET /sms/incoming
  # GET /sms/incoming.xml
  def incoming    
    
    #Read params from the text message
    @userid = params[:uid]
    @body = params[:body]    
    
    smsinfo = Sms.new(:raw => @body)
    
    smsinfo.parseandprocess(@userid, @body)
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    render :text => ""
  
  end

  # GET /sms/send_sms
  # GET /sms/send_sms.xml
  def send_sms
    Sms.send_sms(session[:zeepusername], params[:sendmsg][:messagebody])
    
    @zeep_response = "Message sent to #{session[:zeepusername]}!"
    
    render :action => "testloop"
    
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
