require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sms do
  before(:each) do
    
  end

  it "should be able to detect lat long from a string" do
    raw = "55.5555 -111.2341"
    sms = Sms.new(:raw => raw)
    sms.parse()
    sms.should be_is_geocode
    sms.lat.should == 55.5555
    sms.lng.should == -111.2341
  end

  it "should be able to determine that a raw string is a key" do
    raw = "somekey"
    smsPwd = Sms.new(:raw => raw)
    smsPwd.parse()
    smsPwd.should be_is_key
    smsPwd.key.should == raw
    smsPwd.should_not be_is_geocode
  end
  
  it "should be able to determine that a raw string is a lat long" do
    rawLL = "34.5550 -23.1111"
    smsLL = Sms.new(:raw => rawLL)
    smsLL.parse()
    smsLL.should be_is_geocode
    smsLL.lat.should == 34.5550
    smsLL.lng.should == -23.1111
    smsLL.should_not be_is_key
  end
  
  it "should fail when numbers are given which do not specify full 4 decimal places of lat/lng" do
    rawLL = "34.555 -23.111"
    smsLL = Sms.new(:raw => rawLL)
    smsLL.parse()
    smsLL.should_not be_is_geocode
    smsLL.should_not be_is_key
  end
  
  it "should be able to detect if lat/long came from a geocode address or coordinates" do
    pending "until next sprint"
  end

  it "should gracefully handle not having lat long" do
    raw = "notlatlng"
    sms = Sms.new(:raw => raw)
    sms.parse()
    sms.should_not be_is_geocode
    sms.key.should == raw
  end
  
  it "should gracefully handle when there are more than 2 numbers in the string" do
    raw = "34.555 -23.111 12.768"
    sms = Sms.new(:raw => raw)
    sms.parse()
    sms.should_not be_is_geocode
    sms.should be_is_key
    sms.key.should == raw
  end
  
  it "should handle an empty string" do
    raw = ""
    sms = Sms.new(:raw => raw)
    sms.parse()
    sms.should_not be_is_geocode
    sms.should_not be_is_key
  end
  
  it "should parse and process a string containing lat/lng and determine if its within proximity" do
    #user = create_user(:id => 1, :login => "asime", :email => "asime@o19s.com", :salt => "356a192b7913b04c54574d18c28d46e6395428ab",
    # :crypted_password => "261fd559c11e3931bd9f87fe8babb4ee8b196c56", :created_at => 5.days.ago.to_s, :remember_token_expires_at: 1.days.from_now.to_s,
    # :remember_token => "77de68daecd823babbb58edb1c8e14d7106e83bb", :activated_at => 5.days.ago.to_s, :state => "active")
    
    #raw = "34.555 -23.111"
    #sms = Sms.new(:raw => raw)
    #puts(sms.parseandprocess("asime", raw))
  end
  
end
