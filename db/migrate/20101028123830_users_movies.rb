class UsersMovies < ActiveRecord::Migration

# wannasee

  def self.up
    create_table :users_movies, :id => false, :force => true do |t|
      t.integer :user_id
      t.integer :movie_id
      t.timestamps
    end
  end

  def self.down
    drop_table :users_movies
  end
end
