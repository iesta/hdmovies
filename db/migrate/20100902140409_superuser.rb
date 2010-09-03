class Superuser < ActiveRecord::Migration
  def self.up
    add_column :users, :supesuser, :bool
  end

  def self.down
    remove_column :users, :supesuser
  end
end
