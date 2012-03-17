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

ActiveRecord::Schema.define(:version => 20120317165241) do

  create_table "access_tokens", :force => true do |t|
    t.string   "name"
    t.string   "access_token"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "fbid"
  end

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "facebook_id"
    t.string   "from_name"
    t.string   "from_id"
    t.string   "message",      :limit => 5000
    t.datetime "created_time"
    t.integer  "like_count"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "dataset_id"
  end

  add_index "comments", ["dataset_id"], :name => "index_comments_on_dataset_id"
  add_index "comments", ["post_id"], :name => "index_comments_on_post_id_id"

  create_table "datasets", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "is_user_dataset"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
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
    t.string   "message",       :limit => 5000
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
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "dataset_id"
  end

  add_index "posts", ["dataset_id"], :name => "index_posts_on_dataset_id"
  add_index "posts", ["page_id"], :name => "index_posts_on_page_id"

  create_table "user_comment_tags", :force => true do |t|
    t.integer  "post_id"
    t.integer  "access_token_id"
    t.string   "tag"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "user_comment_tags", ["access_token_id"], :name => "index_user_comment_tags_on_access_token_id"
  add_index "user_comment_tags", ["post_id"], :name => "index_user_comment_tags_on_post_id"

  create_table "user_post_tags", :force => true do |t|
    t.integer  "post_id"
    t.integer  "access_token_id"
    t.string   "tag"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "user_post_tags", ["access_token_id"], :name => "index_user_post_tags_on_access_token_id"
  add_index "user_post_tags", ["post_id"], :name => "index_user_post_tags_on_post_id"

end
