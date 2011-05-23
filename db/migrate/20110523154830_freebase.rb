class Freebase < ActiveRecord::Migration
  def self.up
    add_column :movies, :freebase, :string
  end

  def self.down
    remove_column :movies, :freebase
  end
end