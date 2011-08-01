class HomeController < ApplicationController
  def index
    @last_movies_new = Movie.order('created_at DESC').limit(14)
    @last_movies_edit = Movie.order('updated_at DESC').limit(5)
    @last_critics = Critic.order('updated_at DESC').limit(15)
    @last_visits = User.order('last_request_at DESC').limit(6)
    @last_requests = Request.order('created_at DESC').limit(5)
  end

  def chat
  end

end
