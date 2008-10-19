class HuntersController < ApplicationController
  def index
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
  
  def change_hunt
    @hunts = Hunt.being_planned
    render :template => "hunters/index"
  end
  
  def awaiting_start
    if current_user.hunt
      if (current_user.hunt.aasm_current_state == :hunting)
        redirect_to :action => :continue
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
    render :text => params[:password]
  end
  
  def start
    hunt = Hunt.find(params[:id])
    current_user.hunt = hunt
    current_user.register_hunt
    current_user.save!
    redirect_to :action => :index
  end
  
  def continue
    if current_user.hunt
      @treasure = current_user.current_treasure
    else
      redirect_to :action => :index
    end
  end
end
