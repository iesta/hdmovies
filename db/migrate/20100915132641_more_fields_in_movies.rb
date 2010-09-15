class MoreFieldsInMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :tvserie, :boolean
    add_column :movies, :episodes, :integer
    add_column :movies, :deleted, :boolean
    add_column :movies, :storage, :string
  end

  def self.down
    remove_column :movies, :episodes
    remove_column :movies, :tvserie
    remove_column :movies, :storage
    remove_column :movies, :deleted
  end
end
