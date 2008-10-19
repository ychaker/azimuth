class DropTeams < ActiveRecord::Migration
  def self.up
    drop_table :teams
  end

  def self.down
    create_table "teams", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "start_treasure_id"
      t.integer  "current_treasure_id"
      t.string   "state"
      t.integer  "hunt_id"
    end
  end
end
