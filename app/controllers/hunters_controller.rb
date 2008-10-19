class HuntersController < ApplicationController
  def index
    unless logged_in? 
      redirect_to :controller => :session, :action => :new
    else
      if current_user.hunt
        if current_user.hunt.aasm_current_state == :hunting
          redirect_to :action => :continue
        else
          redirect_to :action => :awaiting_start
        end
      else
        @hunts = Hunt.being_planned
      end
    end
  end
  
  def change_hunt
    @hunts = Hunt.being_planned
    render :template => "hunters/index"
  end
  
  def awaiting_start
    if current_user.hunt
      if current_user.hunt.aasm_current_state == :hunting
        redirect_to :action => :continue
      elsif current_user.hunt.aasm_current_state == :being_planned
        
      else
        flash[:notice] = "The hunt #{current_user.hunt.name} has status #{current_user.hunt.state.humanize} and can't be done again."
        redirect_to hunt_path(current_user.hunt)
      end
    end
  end
  
  def reset
    redirect_to :action => :index
  end
  
  def start_mobile
    render :layout => 'mobile'
  end
  
  def check_clue
    @discovery = Discovery.new(params[:discovery])
    @discovery.treasure = current_user.current_treasure
    @discovery.hunt = current_user.hunt
    @discovery.user = current_user
    
    current_user.hunt.attempt_open_treasure_chest(@discovery, current_user)
    current_user.save!
    current_user.hunt.save!
    @discovery.save!
    
    respond_to do |format|
      if @discovery.success
        flash[:notice] = 'Treasure was successfully found!.'
      else
        if (params[:discovery][:key] != "")
          flash[:notice] = 'Invalid Key! Please try again.'
        elsif (params[:discovery][:lat] && params[:discovery][:lng])
          flash[:notice] = 'You are not close enough! Please try again.'
        end
      end
      
      format.html { redirect_to :action => "continue" }
    end    
  end
  
  def start
    hunt = Hunt.find(params[:id])
    current_user.hunt = hunt
    current_user.register_hunt 
    current_user.save!
    redirect_to :action => :index
  end
  
  def continue
    if current_user.hunt && current_user.hunt.aasm_current_state == :hunting
      @treasure = current_user.current_treasure
      @discovery = Discovery.new
    else
      redirect_to :action => :awaiting_start
    end
  end
end
