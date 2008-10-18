class Pirate < User

  # Check if a pirate has a role.  If we are a pirate, we automatically have hunt_editor
  def has_role?(role)
    if role.to_s == 'hunt_editor'
      true
    else
      super
    end
  end  
end
