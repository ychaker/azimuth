class RenameTeamIdToUserIdInDiscoveries < ActiveRecord::Migration
  def self.up
    rename_column :discoveries, :team_id, :user_id
    
  end

  def self.down
    rename_column :discoveries, :user_id, :team_id
  end
end
