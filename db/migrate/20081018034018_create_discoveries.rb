class CreateDiscoveries < ActiveRecord::Migration
  def self.up
    create_table :discoveries do |t|
      t.integer :treasure_id
      t.float :lat
      t.float :lng
      t.string :proof_of_life

      t.timestamps
    end
  end

  def self.down
    drop_table :discoveries
  end
end
