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
  
#  def self.import_from_csv
#    filename = "#{RAILS_ROOT}/gmovies.tsv"
#     file = File.new(filename, 'r')
#
#     file.each_line("\n") do |row|
#       c = row.gsub(/\\/,'').gsub(/\"/,'').split("\t")
#       m = Movie.new(:title => c[0])
#       if c[1] =~ /^http/
#         m.url_imdb = c[1]
#       else
#         m.cast = c[1]
#       end
#       m.url_imdb = c[2]
#       m.url_imdb = c[19]
#       m.body = c[3]
#       m.imdb_score = c[4].gsub(',','.').to_f if (c[4] && c[4].size>0)
#       m.quality = c[6] unless c[6] =~ /x/
#       m.languages = c[7]
#       m.subs = c[8]
#       if c[9] && c[9].size>0
#         m.user_id = User.find_by_username('edlambi').id
#       else
#         m.user_id = User.find_by_username('iesta').id
#       end
#       m.alt_title = c[18]
#       m.save
#       
#       o = Array.new
#       o[0]='iesta'
#       o[1]='popcorn'
#       o[2]='kryssix'
#       o[3]='edlambi'
#       
#       [0,1,2,3].each{|j|
#         i = j*2
#         if c[10+i] && c[10+i].size>0
#           sc = c[11+i].gsub(',','.').to_f if c[11+i]
#           m.critics << Critic.new(:user_id => User.find_by_username(o[j]).id, :score => sc, :content => c[10+i])
#         end
#       }
#     end
#  end

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