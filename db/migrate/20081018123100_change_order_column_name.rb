class ChangeOrderColumnName < ActiveRecord::Migration
  def self.up
    rename_column :treasures, :order, "position"
  end

  def self.down
    rename_column :treasures, :position, "order"
  end
end
