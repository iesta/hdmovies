class Movie < ActiveRecord::Base
  has_many :critics  
  
  # import from csv google doc
  def self.import_from csv
    
  end
end
