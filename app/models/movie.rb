class Movie < ActiveRecord::Base
  has_many :critics  
  has_attached_file :photo, 
                    :styles => { :xsmall => "60x60>", :small => "150x150>", :medium => "300x300>", :large => "600x600>" },
                    :url  => "/assets/movies/:style/:id_:basename.:extension",
                    :path => ":rails_root/public/assets/movies/:style/:id_:basename.:extension"
  
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  
  # import from csv google doc
  def self.import_from_csv
    
  end
  
  def delete_photo=(value)
    @delete_photo = !value.to_i.zero?
  end

  def delete_photo
    !!@delete_photo
  end

  alias_method :delete_photo?, :delete_photo

  before_validation :clear_photo

  # Later in the model
  def clear_photo
    self.photo = nil if delete_photo? && !photo.dirty?
  end

end
