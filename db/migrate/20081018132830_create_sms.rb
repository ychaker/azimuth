class CreateSms < ActiveRecord::Migration
  def self.up
    create_table :sms do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :sms
  end
end
