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
    smsPwd.lat.should == 0.00
    smsPwd.lng.should == 0.00
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
  
  it "should handle calculating is a lat long coordinate within proximity of another set of ccordinates" do
    pending "until next sprint"
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
  
end
