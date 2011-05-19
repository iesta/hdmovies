class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_api
  
  api_accessible :base do |template|
     template.add :id
     template.add :username
     template.add :critics_count
  end
  
  has_many :critics, :order => "created_at DESC"
  has_many :requests
  has_and_belongs_to_many :movies, :join_table => "users_movies", :order => "users_movies.created_at DESC"
  
  def critic_on(movie)
    return Critic.find(:first, :conditions => ["movie_id = ? AND user_id = ?", movie.id, self.id])
  end
  
#  def as_json(options={})
#    logger.debug "as_json called"
#    super(:except => [:created_at, :updated_at, :crypted_password, :current_login_at, :current_login_ip, :email, :failed_login_count, :last_login_ip, :last_request_at, ])
#  end

  # used by api
  def critics_count
    self.critics.count
  end
  
  # this return a list of movie not yet criticized
  def mustsee
    # must use this 2 steps becausesqlite doe snot support right joins or the join i needed
    seen = Critic.where(["user_id = ?",self.id]).select('movie_id').map{|m| m.movie_id}.join(',')
    Movie.where("id NOT IN (#{seen})")
  end
end
