class MoreUrlFieldsForMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :wikipedia_url, :string
    add_column :movies, :traileraddict_url, :string
  end

  def self.down
    remove_column :movies, :traileraddict_url
    remove_column :movies, :wikipedia_url
  end
end