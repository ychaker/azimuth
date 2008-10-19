class Sms < ActiveRecord::Base
  
  @keyexists = false
  @geocodeexists = false
  
  def is_key?
    return @keyexists
  end
  
  def is_geocode?
    return @geocodeexists
  end
  
  def parse()
    self.lat = 0.00
    self.lng = 0.00
    if (raw != "")
      if (raw.split(/\s+/).size != 2)
        @keyexists = true
        self.key = self.raw
      else
        @geocodeexists = true
        for s in raw.split(/\s+/)
          regex = /[-]?[0-9][.]{0,1}[0-9]{4}/
          @geocodeexists = (regex.match(s)) && @geocodeexists
        end
        if (@geocodeexists)
          self.lat = raw.split(/\s+/)[0]
          self.lng = raw.split(/\s+/)[1]
        end
      end
    end
  end  
  
end
