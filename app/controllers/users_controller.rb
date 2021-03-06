class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  
  def index
    @users = User.find(:all)
  end
  
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    if using_open_id?
      authenticate_with_open_id(params[:openid_url], :return_to => open_id_create_url, 
        :required => [:nickname, :email]) do |result, identity_url, registration|
        if result.successful?
          create_new_user(:identity_url => identity_url, :login => registration['nickname'], :email => registration['email'])
        else
          failed_creation(using_open_id?, result.message || "Sorry, something went wrong")
        end
      end
    else
      create_new_user(params[:user])
    end
    
    
  end
   
  def profile
    @user = current_user
    @smstest = Sms.new(:login => @user.login, :raw => "This is a test SMS message from Azimuth.  You are configured correctly!")
  end
  
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to :action => :profile}
        format.xml  { head :ok }
      else
        format.html { render :action => "profile" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def sendtestsms
    Sms.send_sms(current_user.login, params[:sms][:raw])
    flash[:notice] = 'Test SMS message sent.'
    
    respond_to do |format|
      format.html { redirect_to :action => :profile}
    end
  end
  
  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to login_path
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default(root_path)
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default(root_path)
    end
  end
  
  protected
  
  def create_new_user(attributes)
    @user = User.new(attributes)
    
    # if we don't have a login, derive it from open id.
    if @user.login.blank? and !@user.identity_url.blank?
      s = @user.identity_url
      
      s = s[7..s.length] if s.starts_with?("http://")
      s = s[0..(s.length - 2)] if s.ends_with?('/')
      #puts s
      @user.login = s
    end
    
    open_id = @user.identity_url.blank? ? false : true
    
    #ip = request.env['HTTP_X_CLUSTER_CLIENT_IP'].blank? ? request.remote_ip : request.env['HTTP_X_CLUSTER_CLIENT_IP']
    #begin
      #@user.set_coord_from_maxmind(ip)
    #rescue LocationNotFound
    #end

    if @user && @user.valid?
      if @user.not_using_openid?
        @user.register!
      else
        @user.register_openid!
      end
    end
    
    if @user.errors.empty?
      successful_creation(@user)
    else
      failed_creation(open_id)
    end
  end
  
  def successful_creation(user)
    self.current_user = user
    redirect_back_or_default(welcome_url)
    #redirect_back_or_default(:controller => :users, :action => :profile)
    flash[:notice] = "Thanks for signing up!"
#    flash[:notice] << " We're sending you an email with your activation code." if @user.not_using_openid?
#    flash[:notice] << " You can now login with your OpenID." unless @user.not_using_openid?
  end
  
  def failed_creation(open_id, message = 'Sorry, there was an error creating your account')
    flash[:error] = message
    if open_id
      redirect_to :action => :new, :using_open_id => open_id
    else
      render :action => :new, :using_open_id => open_id
    end
  end
end
