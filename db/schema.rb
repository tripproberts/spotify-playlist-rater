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

ActiveRecord::Schema.define(version: 20141205201101) do

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "hipster_scores", force: true do |t|
    t.float    "score",                default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "playlist_snapshot_id"
    t.integer  "playlist_id"
    t.integer  "user_id"
  end

  create_table "playlists", force: true do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spotify_url"
    t.string   "owner_name"
    t.string   "owner_id"
  end

  create_table "users", force: true do |t|
    t.text     "spotify_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
