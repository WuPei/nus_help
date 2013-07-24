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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130723145323) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.boolean  "status",         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "micropost_id"
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", force: true do |t|
    t.integer  "uid"
    t.string   "content"
    t.string   "from"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "help_recs", force: true do |t|
    t.integer  "helper_id"
    t.string   "helper_comment"
    t.string   "owner_comment"
    t.string   "feedback_comment"
    t.string   "contact_info"
    t.boolean  "online"
    t.boolean  "is_happy"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
  end

  create_table "likeships", force: true do |t|
    t.integer  "liked_micropost_id"
    t.integer  "liker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likeships", ["liked_micropost_id", "liker_id"], name: "index_likeships_on_liked_micropost_id_and_liker_id", unique: true, using: :btree
  add_index "likeships", ["liked_micropost_id"], name: "index_likeships_on_liked_micropost_id", using: :btree
  add_index "likeships", ["liker_id"], name: "index_likeships_on_liker_id", using: :btree

  create_table "microposts", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.string   "gift"
    t.string   "module_code"
    t.integer  "module_id"
    t.string   "deadline"
    t.boolean  "is_anonymous"
    t.integer  "status",         default: 0
    t.integer  "user_id"
    t.integer  "helper_id"
    t.boolean  "is_happy",       default: false
    t.integer  "click_count",    default: 0
    t.integer  "comments_count"
    t.boolean  "is_online"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree

  create_table "module_followings", force: true do |t|
    t.integer  "mod_id"
    t.integer  "mod_follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "module_followings", ["mod_follower_id"], name: "index_module_followings_on_mod_follower_id", using: :btree
  add_index "module_followings", ["mod_id", "mod_follower_id"], name: "index_module_followings_on_mod_id_and_mod_follower_id", unique: true, using: :btree
  add_index "module_followings", ["mod_id"], name: "index_module_followings_on_mod_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "from_uid"
    t.integer  "to_uid"
    t.text     "content"
    t.string   "related_url"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nus_modules", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.integer  "follower_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nus_modules", ["code"], name: "index_nus_modules_on_code", unique: true, using: :btree
  add_index "nus_modules", ["follower_count"], name: "index_nus_modules_on_follower_count", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "user_imgs", force: true do |t|
    t.integer  "user_id"
    t.string   "origin"
    t.string   "cropped"
    t.integer  "cx"
    t.integer  "cy"
    t.integer  "cw"
    t.integer  "ch"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "remember_token"
    t.string   "account"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",          default: false
    t.integer  "gender"
  end

  add_index "users", ["account"], name: "index_users_on_account", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
