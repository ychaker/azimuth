class Sms < ActiveRecord::Base
  
  def is_key?
    return !self.key.nil?
  end
  
  def is_geocode?
    return !self.lat.nil? & !self.lng.nil?
  end
  
  def parse()
    if raw != ""
      if raw.split(/\s+/).size != 2
        self.key = self.raw
      else
        @geocodeexists = true
        for s in raw.split(/\s+/)
          regex = /[-]?[0-9][.]{0,1}[0-9]{4}/ #fixme need to allow more than 4 decimal places
          @geocodeexists = (regex.match(s)) && @geocodeexists
        end
        if @geocodeexists
          self.lat = raw.split(/\s+/)[0]
          self.lng = raw.split(/\s+/)[1]
        end
      end
    end
  end  
  
  def parseandprocess(userid, body)
    
    if (body == nil)
      return "page accessed directly.  should only be accessed via post after a text message"
    else  
      
      #parse the content of the text message
      smsinfo = Sms.new(:raw => body)
      smsinfo.parse()
      @reply_message = "User: #{userid}, "
      if (smsinfo.is_geocode?)
        @reply_message += " lat: #{smsinfo.lat} lng: #{smsinfo.lng} "
      end
      if (smsinfo.is_key?)
        @reply_message += " key: #{smsinfo.key} "
      end  
      
      #look up the user based on the user id
      user = User.find_by_login(userid)
      if user
        #find out the hunt that the user is working on
        t = user.current_treasure 

        @success = false
        if smsinfo.is_geocode?
          #check their discovery to see if it is valid
          #puts("lat #{smsinfo.lat} lng #{smsinfo.lng}")
          d = Discovery.create!(:lat => smsinfo.lat.to_f, :lng => smsinfo.lng.to_f)
          #puts("did #{d.id}, tid #{d.treasure_id}, lat #{d.lat}, lng #{d.lng}")
          #puts("tid #{t.id}, lat #{t.lat}, lng #{t.lng}")
          distance = Treasure.distance_between(d, t)
          if t.proximate?(d)
            @success = true
          end
        else
          #check if the given key is valid
          if t.key == smsinfo.key
            @success = true
          end
        end
        
        if (@success)
          #save the discovery and let texter know their next clue
          @reply_message += "SUCCESS!  Your next clue is PARROT"
        else
          #not a valid discovery!  give the texter some feedback
          #still save the discovery however
          @reply_message += "FAILURE.  Try again."
        end

        #display reply message to send back to texter
        return @reply_message
      else
        return "Invalid userid: #{userid}.  Please contact your pirate to sign up before you can hunt for treasure."
      end  
      
    end
  end
  
end
