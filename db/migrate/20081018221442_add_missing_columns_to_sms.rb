class AddMissingColumnsToSms < ActiveRecord::Migration
  def self.up
    add_column :sms, :raw, :string
    add_column :sms, :lat, :float
    add_column :sms, :lng, :float
    add_column :sms, :key, :string
  end

  def self.down
    remove_column :sms, :key
    remove_column :sms, :lng
    remove_column :sms, :lat
    remove_column :sms, :raw
  end
end
