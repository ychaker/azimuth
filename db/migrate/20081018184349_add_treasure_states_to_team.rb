class AddTreasureStatesToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :start_treasure_id, :integer
    add_column :teams, :current_treasure_id, :integer
  end

  def self.down
    remove_column :teams, :current_treasure_id
    remove_column :teams, :start_treasure_id
  end
end
