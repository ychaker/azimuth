class AddPirateIdToHunt < ActiveRecord::Migration
  def self.up
    add_column :hunts, :pirate_id, :integer
  end

  def self.down
    remove_column :hunts, :pirate_id
  end
end
