class User < ActiveRecord::Base
  acts_as_authentic
  has_many :critics, :order => "created_at DESC"
  has_many :requests
  has_and_belongs_to_many :movies, :join_table => "users_movies", :order => "users_movies.created_at DESC"
  
  def critic_on(movie)
    return Critic.find(:first, :conditions => ["movie_id = ? AND user_id = ?", movie.id, self.id])
  end
end
