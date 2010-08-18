class MoreFieldsToMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :year, :integer
    add_column :movies, :facebook_url, :string
  end

  def self.down
    remove_column :movies, :facebook_url
    remove_column :movies, :year
  end
end
