class Critic < ActiveRecord::Base
  acts_as_api
  
  api_accessible :base do |template|
    self.column_names.each{|c|
        template.add c.to_sym
    }
    template.add :user
    template.add :public_url
  end

  belongs_to :movie, :dependent => :destroy
  belongs_to :user
  
  validates_numericality_of :score, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 20

  after_save :update_movie_score
  
  def update_movie_score
    self.movie.update_average_score
  end
  
  # public url for api
   def public_url
     "#{URL}/critics/#{self.id}"
   end
  
end
