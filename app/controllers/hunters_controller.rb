class HuntersController < ApplicationController
  def index
    if (session[:hunt])
      h = Hunt.find(session[:hunt].id)
      puts h.aasm_current_state
      if (h.aasm_current_state == :hunting)
        redirect_to :action => :continue
      else
        redirect_to :action => :awaiting_start
      end
    else
      @hunts = Hunt.being_planned
    end
  end
  
  def awaiting_start
    if (session[:hunt])
      h = Hunt.find(session[:hunt].id)
      if (h.aasm_current_state == :hunting)
        redirect_to :action => :continue
      end
    end
  end
  
  def reset
    session[:hunt] = nil
    session[:hunt_treasures] = nil
    session[:hunt_start] = nil
    session[:hunt_current] = nil
    redirect_to :action => :index
  end
  
  def start_mobile
    
  end
  
  def start
    session[:hunt] = Hunt.find(params[:id])
    session[:hunt_start] = rand(session[:hunt].treasures.size)
    session[:hunt_current] = session[:hunt_start]
    redirect_to :action => :index
  end
  
  def continue
    if (session[:hunt])
      treasures = Hunt.find(session[:hunt].id).treasures
      @treasure = treasures[session[:hunt_current]]
    else
      redirect_to :action => :index
    end
  end
end
