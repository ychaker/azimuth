class AddStatusToHunt < ActiveRecord::Migration
  def self.up
    add_column :hunts, :state, :string
  end

  def self.down
    remove_column :hunts, :state
  end
end
