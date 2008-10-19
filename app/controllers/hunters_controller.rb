class HuntersController < ApplicationController
  def index
    @hunts = Hunt.hunting
    
    # THink about if we want to filter out owners....
    #@hunts = @hunts.select{ |h| h.user != current_user }
    if (session[:hunt])
      redirect_to :action => :continue
    end
  end
  
  def reset
    session[:hunt] = nil
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
    redirect_to :action => :continue
  end
  
  def continue
    if (session[:hunt])
      @treasure = session[:hunt].treasures[session[:hunt_current]]
    else
      redirect_to :action => :index
    end
  end
end
