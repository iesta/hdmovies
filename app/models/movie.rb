class Movie < ActiveRecord::Base
  has_many :critics  
  
  # import from csv google doc
  def self.import_from_csv
    
  end
end
