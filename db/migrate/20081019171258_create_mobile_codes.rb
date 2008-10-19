class CreateMobileCodes < ActiveRecord::Migration
  def self.up
    create_table :mobile_codes do |t|
      t.integer :user_id
      t.integer :hunt_id
      t.integer :code

      t.timestamps
    end
  end

  def self.down
    drop_table :mobile_codes
  end
end
