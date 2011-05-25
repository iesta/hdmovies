class HomeController < ApplicationController
  def index
    @last_movies_new = Movie.order('created_at DESC').limit(8)
    @last_movies_edit = Movie.order('updated_at DESC').limit(10)
    @last_critics = Critic.order('created_at DESC').limit(15)
    @last_visits = User.order('last_request_at DESC').limit(8)
  end

  def chat
  end

end
