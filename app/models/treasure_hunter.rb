class TreasureHunter < User
  
  def code_name
    login
  end
  
  # Check if a treasure hunter has a role.  If we are a treasure hunter, we automatically have treasure_hunter
  def has_role?(role)
    if role.to_s == 'treasure_hunter'
      true
    else
      super
    end
  end  
end
