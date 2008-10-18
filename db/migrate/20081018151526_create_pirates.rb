class CreatePirates < ActiveRecord::Migration
  # Add type to users so we can do STI with Pirates and TreasureHunters
  
  def self.up
    add_column :users, :type, :string
  end

  def self.down
    remove_column :users, :type
  end
end
