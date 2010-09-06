class Critic < ActiveRecord::Base
  belongs_to :movie, :dependent => :destroy
  belongs_to :user
  
  validates_numericality_of :score, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 20
  
end
