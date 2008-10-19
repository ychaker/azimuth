class AddLoginToSms < ActiveRecord::Migration
  def self.up
    add_column :sms, :login, :string
  end

  def self.down
    remove_column :sms, :login
  end
end
