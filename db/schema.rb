# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100214224510) do

  create_table "movies", :force => true do |t|
    t.string   "title"
    t.string   "alt_title"
    t.string   "origin"
    t.string   "filename"
    t.text     "body"
    t.text     "plot"
    t.string   "url_imdb"
    t.string   "url_allocine"
    t.string   "imdb_score"
    t.string   "quality"
    t.string   "languages"
    t.string   "subs"
    t.text     "cast"
    t.string   "director"
    t.string   "country"
    t.string   "size"
    t.string   "format"
    t.integer  "user_id"
    t.string   "youtube_url"
    t.text     "embed_movie"
    t.string   "apple_url"
    t.string   "amazon_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
