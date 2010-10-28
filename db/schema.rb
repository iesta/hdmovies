# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101028163755) do

  create_table "critics", :force => true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.text     "content"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "main_img_file_name"
    t.string   "main_img_content_type"
    t.integer  "main_img_file_size"
    t.datetime "main_img_updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "year"
    t.string   "facebook_url"
    t.boolean  "tvserie"
    t.integer  "episodes"
    t.boolean  "deleted"
    t.string   "storage"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

# Could not dump table "users" because of following StandardError
#   Unknown type 'bool' for column 'supesuser'

  create_table "users_movies", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
