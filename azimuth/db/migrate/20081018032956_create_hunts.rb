class CreateHunts < ActiveRecord::Migration
  def self.up
    create_table :hunts do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :hunts
  end
end
