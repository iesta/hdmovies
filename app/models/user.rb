class User < ActiveRecord::Base
  acts_as_authentic
  has_many :critics
  has_and_belongs_to_many :movies, :join_table => "users_movies"
  
  def critic_on(movie)
    return Critic.find(:first, :conditions => ["movie_id = ? AND user_id = ?", movie.id, self.id])
  end
end
