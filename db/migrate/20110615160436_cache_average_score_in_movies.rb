class CacheAverageScoreInMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :average_score, :decimal
  end

  def self.down
    remove_column :movies, :average_score
  end
end