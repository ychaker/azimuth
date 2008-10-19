class AddStateToTeam < ActiveRecord::Migration
  def self.up
    add_column :teams, :state, :string
  end

  def self.down
    remove_column :teams, :state
  end
end
