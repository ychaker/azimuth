class HuntersController < ApplicationController
  def index
    @hunts = Hunt.hunting.select{ |h| h.user != current_user }
    puts @hunts.inspect
    if (session[:hunt])
      redirect_to :action => :continue
    end
    
  end
  
  def start
    session[:hunt] = Hunt.find(params[:id])
    redirect_to :action => :continue
  end
  
  def continue
    # puts current_user
    render  :text => current_user
  end
end
