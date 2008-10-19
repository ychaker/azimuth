class RenamePasswordToKeyForTreasure < ActiveRecord::Migration
  def self.up
    rename_column :treasures, :password, "key"
  end

  def self.down
    rename_column :treasures, :key, "password"
  end
end
