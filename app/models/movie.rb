class Movie < ActiveRecord::Base
  acts_as_api

  api_accessible :base do |template|
    self.column_names.each{|c|
        template.add c.to_sym
    }
    template.add :public_url
    template.add :base_photo_url
    template.add :average
    template.add :id
    template.add :user
  end
  
  belongs_to :user
  has_many :critics, :dependent => :destroy, :order => "created_at DESC"
  has_and_belongs_to_many :users, :join_table => "users_movies"
  acts_as_taggable_on :genre
  has_attached_file :photo, 
                    :styles => { :xsmall => "60x60>", :small => "150x150>", :medium => "300x300>", :large => "500x500>" },
                    :url  => "/assets/movies/:style/:id_:basename.:extension",
                    :path => ":rails_root/public/assets/movies/:style/:id_:basename.:extension"
  
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
  validates_presence_of :title

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
  
  # average of the critics || nil
  def average
    if self.critics.size>0
      begin
        self.critics.map{|i| i.score.to_f}.inject{ |sum, el| sum + el }.to_f / self.critics.size.to_f
      rescue
        nil
      end
    end
  end
  
# public url for api
 def public_url
   "#{URL}/movies/#{self.id}"
 end
 
 # photo url for api
 # replace "large" by small, xsmall, ... if needed
 def base_photo_url
   "#{URL}#{self.photo.url}/".gsub('/original/','/large/')
 end
end