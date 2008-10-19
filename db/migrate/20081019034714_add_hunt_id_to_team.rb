class AddHuntIdToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :hunt_id, :integer
  end

  def self.down
    remove_column :teams, :hunt_id
  end
end
