# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120309032305) do

  create_table "access_tokens", :force => true do |t|
    t.string   "name"
    t.string   "access_token"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "fbid"
  end

  create_table "pages", :force => true do |t|
    t.string   "facebook_id"
    t.string   "name"
    t.string   "photo_url"
    t.string   "username"
    t.boolean  "can_post"
    t.integer  "like_count"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "page_id"
    t.string   "facebook_id"
    t.string   "from_name"
    t.string   "from_id"
    t.string   "message"
    t.string   "type"
    t.datetime "created_time"
    t.string   "photo_url"
    t.string   "link_url"
    t.string   "link_name"
    t.string   "link_caption"
    t.string   "link_desc"
    t.string   "video_url"
    t.integer  "like_count"
    t.integer  "comment_count"
    t.integer  "share_count"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "posts", ["page_id"], :name => "index_posts_on_page_id"

end
