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

ActiveRecord::Schema.define(:version => 20120503025859) do

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
    t.text     "from_name"
    t.string   "from_id"
    t.text     "message"
    t.datetime "created_time"
    t.integer  "like_count"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id_id"

  create_table "datasets", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "is_user_dataset"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "lda_post_tags", :force => true do |t|
    t.integer  "post_id"
    t.integer  "lda_topic_id"
    t.integer  "strategy_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "lda_post_tags", ["lda_topic_id"], :name => "index_lda_post_tags_on_lda_topic_id"
  add_index "lda_post_tags", ["post_id"], :name => "index_lda_post_tags_on_post_id"
  add_index "lda_post_tags", ["strategy_id"], :name => "index_lda_post_tags_on_strategy_id"

  create_table "lda_post_topics", :force => true do |t|
    t.integer  "post_id"
    t.integer  "lda_topic_id"
    t.float    "weight"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "lda_post_topics", ["lda_topic_id"], :name => "index_lda_post_topics_on_lda_topic_id"
  add_index "lda_post_topics", ["post_id"], :name => "index_lda_post_topics_on_post_id"

  create_table "lda_topic_words", :force => true do |t|
    t.integer  "lda_topic_id"
    t.decimal  "weight",       :precision => 10, :scale => 0
    t.integer  "tokens"
    t.string   "word"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "lda_topic_words", ["lda_topic_id"], :name => "index_lda_topic_words_on_lda_topic_id"

  create_table "lda_topics", :force => true do |t|
    t.decimal  "alpha",         :precision => 10, :scale => 0
    t.string   "title"
    t.integer  "tokens"
    t.integer  "mallet_run_id"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "lda_topics", ["mallet_run_id"], :name => "index_lda_topics_on_mallet_run_id"

  create_table "mallet_commands", :force => true do |t|
    t.integer  "mallet_run_id"
    t.text     "command"
    t.text     "stdout"
    t.text     "stderr"
    t.integer  "exit_status"
    t.string   "state"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "mallet_commands", ["mallet_run_id"], :name => "index_mallet_commands_on_mallet_run_id"

  create_table "mallet_runs", :force => true do |t|
    t.string   "name"
    t.integer  "num_topics"
    t.integer  "num_iterations"
    t.integer  "optimize_burn_in"
    t.boolean  "use_symetric_burn_in"
    t.decimal  "alpha",                :precision => 10, :scale => 0
    t.integer  "dataset_id"
    t.integer  "state"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  add_index "mallet_runs", ["dataset_id"], :name => "index_mallet_runs_on_dataset_id"

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
    t.text     "from_name"
    t.string   "from_id"
    t.text     "message"
    t.string   "type"
    t.datetime "created_time"
    t.text     "photo_url"
    t.text     "link_url"
    t.text     "link_name"
    t.text     "link_caption"
    t.text     "link_desc"
    t.text     "video_url"
    t.integer  "like_count"
    t.integer  "comment_count"
    t.integer  "share_count"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "dataset_id"
    t.text     "search"
  end

  add_index "posts", ["dataset_id"], :name => "index_posts_on_dataset_id"
  add_index "posts", ["page_id"], :name => "index_posts_on_page_id"

  create_table "stats", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.text     "options"
    t.string   "type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "strategies", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "type"
    t.text     "options"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

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
