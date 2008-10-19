class AddHuntToDiscovery < ActiveRecord::Migration
  def self.up
    add_column :discoveries, :hunt_id, :integer
  end

  def self.down
    remove_column :discoveries, :hunt_id
  end
end
