class HuntersController < ApplicationController
  def index
    if (session[:hunt])
      redirect_to :action => :continue
    end
  end
  
  def start
    session[:hunt] = Hunt.find(params[:id])
    redirect_to :action => :continue
  end
  
  def continue
    render  :text => current_user.team
  end
end
