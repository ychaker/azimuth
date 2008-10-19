class Refactorteamintouser < ActiveRecord::Migration
  def self.up
    rename_column :users, :team_id, :start_treasure_id
    add_column :users, :current_treasure_id, :integer
    add_column :users, :hunt_id, :integer
    
  end

  def self.down
    rename_column :users, :start_treasure_id, :team_id
    remove_column :users,:current_treasure_id
    remove_column :users,:hunt_id
  end
end
