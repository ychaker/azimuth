class CreateTreasures < ActiveRecord::Migration
  def self.up
    create_table :treasures do |t|
      t.string :name
      t.string :image
      t.string :clue
      t.string :description
      t.integer :hunt_id
      t.integer :order
      t.float :lat
      t.float :lng
      t.float :proximity
      t.integer :points
      t.string :password

      t.timestamps
    end
  end

  def self.down
    drop_table :treasures
  end
end
