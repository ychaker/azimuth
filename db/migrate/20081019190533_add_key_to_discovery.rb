class AddKeyToDiscovery < ActiveRecord::Migration
  def self.up
    add_column :discoveries, :key, :string
    remove_column :discoveries, :proof_of_life
  end

  def self.down
    remove_column :discoveries, :key
    add_column :discoveries, :proof_of_life, :string
  end
end
