class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.string :title
      t.string :alt_title
      t.string :origin
      t.string :filename
      t.text :body
      t.text :plot
      t.string :url_imdb
      t.string :url_allocine
      t.string :imdb_score
      t.string :quality
      t.string :languages
      t.string :subs
      t.text :cast
      t.string :director
      t.string :country
      t.string :size
      t.string :format
      t.integer :user_id
      t.string :youtube_url
      t.text :embed_movie
      t.string :apple_url
      t.string :amazon_url

      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
