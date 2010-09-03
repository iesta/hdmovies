class Superuser < ActiveRecord::Migration
  def self.up
    add_column :users, :superuser, :bool
  end

  def self.down
    remove_column :users, :superuser
  end
end
