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
    response.headers["Content-Type"] = "text/plain; charset=utf-8"
    #Read params from the text message
    
    if (params[:uid] && params[:body])
      @userid = params[:uid]
      @body = params[:body]    
    
      sms = Sms.new(:raw => @body, :login => @userid)
    
      sms.parse
    
      user = User.find_by_login(sms.login)
    
      if user.nil?
        render :text => "User #{sms.login} couldn't be found, have you signed up at #{AZIMUTH_DOMAIN}?" 
      else
        hunt = user.hunt
        if hunt.nil?
          render :text => "User #{sms.login} doesn't appear to have signed up for a hunt.  Please sign up for one at #{AZIMUTH_DOMAIN}."
        else
          if hunt.aasm_current_state == :hunting
            discovery = Discovery.new(:treasure => user.current_treasure, :key => sms.key, :lat => sms.lat, :lng => sms.lng, :hunt => hunt, :user => user)
            hunt.attempt_open_treasure_chest(discovery, user)
            user.save!
            hunt.save!
            discovery.save!
        
            if discovery.success?
              render :text => ""  # don't send extra texts since the hunt will do it for us...
            else
              render :text => "What you texted didn't open the treasure chest :-(.  Coords: #{sms.lat} #{sms.lng}.  Key: #{sms.key}"
            end
          else
            render :text => "The hunt #{hunt.name} is currently in #{hunt.state.humanize} state.  Please wait for the hounds to be released to get your first clue."
          end
        end
      end
    else
      render :text => ""
    end
  
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
