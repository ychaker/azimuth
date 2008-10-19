class RenamePirateIdToUserIdInHunt < ActiveRecord::Migration
    def self.up
      rename_column :hunts, :pirate_id, :user_id
    end

    def self.down
      rename_column :hunts, :user_id, :pirate_id
    end
  end