class User < ActiveRecord::Base
  acts_as_authentic
  has_many :critics
  
  def critic_on(movie)
    return Critic.find(:first, :conditions => ["movie_id = ?",movie.id])
  end
end
