require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles
  
  aasm_state :hunt_registering
  aasm_state :hunt_hunting#, :enter => :announce_start_of_hunt
  
  belongs_to :hunt
  has_many :hunts 

  belongs_to :start_treasure, :class_name => "Treasure" 
  belongs_to :current_treasure, :class_name => "Treasure"
  
  has_many :discoveries
  

  # Validations
  validates_presence_of :login, :if => :not_using_openid?
  validates_length_of :login, :within => 3..40, :if => :not_using_openid?
  validates_uniqueness_of :login, :case_sensitive => false, :if => :not_using_openid?
  validates_format_of :login, :with => RE_LOGIN_OK, :message => MSG_LOGIN_BAD, :if => :not_using_openid?
  validates_format_of :name, :with => RE_NAME_OK, :message => MSG_NAME_BAD, :allow_nil => true
  validates_length_of :name, :maximum => 100
  validates_presence_of :email, :if => :not_using_openid?
  validates_length_of :email, :within => 6..100, :if => :not_using_openid?
  validates_uniqueness_of :email, :case_sensitive => false, :if => :not_using_openid?
  validates_format_of :email, :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD, :if => :not_using_openid?
  validates_uniqueness_of :identity_url, :unless => :not_using_openid?
  validate :normalize_identity_url
  
  # Relationships
  has_and_belongs_to_many :roles

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :identity_url

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_in_state :first, :active, :conditions => { :login => login } # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  # Check if a user has a role.
  def has_role?(role)
    list ||= self.roles.map(&:name)
    list.include?(role.to_s) || list.include?('admin')
  end
  
  # Not using open id
  def not_using_openid?
    identity_url.blank?
  end
  
  # Overwrite password_required for open id
  def password_required?
    new_record? ? not_using_openid? && (crypted_password.blank? || !password.blank?) : !password.blank?
  end
  
  ######
  aasm_event :register_hunt do
     transitions :to => :hunt_registering, :from => [:active]
   end
   
  aasm_event :begin_hunt do
     transitions :to => :hunt_hunting, :from => [:hunt_registering]
   end

   aasm_event :finish_hunt do 
     transitions :to => :active, :from => [:hunt_hunting]
   end

   aasm_event :cancel do 
     transitions :to => :active, :from => [:hunt_registering, :hunt_hunting]
   end
  
  def score
    points = 0
    discoveries_for_hunt = self.discoveries.select{ |discovery| discovery.hunt == self.hunt }
    
    successful_discoveries = discoveries_for_hunt.select{ |discovery| discovery.success? }
    successful_discoveries.each {|discovery| points += discovery.treasure.points } 
    
    points
  end
  
  def start_hunt(treasure)
    self.start_treasure = treasure
    self.current_treasure = treasure
    self.begin_hunt
  end
  
  def join_hunt(hunt)
    hunt.users << self
    self.register_hunt
  end
  
  def send_next_clue
    puts "Trying to send clues to folks!"
    if self.email
      puts "Now emailing #{self.login} about clue: #{self.current_treasure.clue}"
    end
    
    #FIXME add validation that zeep account exists
    Sms.send_sms(self.login, "#{self.hunt.name}: Your clue is #{self.current_treasure.clue}.")
    
    #if self.zeeped?
    #  logger.error "Now sending text message about your clue: #{self.current_treasure.clue}"
    #end
  end
  
  def send_message (message)
    puts "Sending message to #{self.login}: #{message}"
  end
  

  protected
    
  def make_activation_code
    self.deleted_at = nil
    self.activation_code = self.class.make_token
  end
  
  def normalize_identity_url
    self.identity_url = OpenIdAuthentication.normalize_url(identity_url) unless not_using_openid?
  rescue URI::InvalidURIError
    errors.add_to_base("Invalid OpenID URL")
  end
end
