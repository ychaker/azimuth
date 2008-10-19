class AddSuccessAndTeamToDiscovery < ActiveRecord::Migration
  def self.up
    add_column :discoveries, :team_id, :integer
    add_column :discoveries, :success, :boolean
  end

  def self.down
    remove_column :discoveries, :success
    remove_column :discoveries, :team_id
  end
end
