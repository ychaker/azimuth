class TeamEntry < ActiveRecord::Migration
  def self.up
    create_table :team_entries do |t|
      t.integer :team_id
      t.integer :hunt_id

      t.timestamps
    end
  end

  def self.down
    drop_table :team_entries
  end
end
