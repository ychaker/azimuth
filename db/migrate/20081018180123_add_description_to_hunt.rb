class AddDescriptionToHunt < ActiveRecord::Migration
  def self.up
    add_column :hunts, :description, :string
  end

  def self.down
    remove_column :hunts, :description
  end
end
