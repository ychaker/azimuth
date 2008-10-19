class PirateController < ApplicationController
  def index
    unless logged_in? 
      redirect_to :controller => :session, :action => :new
    end
#    @hunt = Hunt.find(:first) # AZTODO Make hunt based on current hunt (session?)
  end
end
