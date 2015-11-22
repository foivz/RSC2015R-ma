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

ActiveRecord::Schema.define(version: 20151122091442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fields", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.decimal  "latitude_nw",  precision: 8, scale: 6, null: false
    t.decimal  "longitude_nw", precision: 9, scale: 6, null: false
    t.decimal  "latitude_se",  precision: 8, scale: 6, null: false
    t.boolean  "occupied"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "longitude_se", precision: 9, scale: 6, null: false
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.integer  "type"
    t.integer  "duration"
    t.string   "pin"
    t.integer  "field_id"
    t.integer  "team_a_id"
    t.integer  "team_b_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "active",     default: false
    t.datetime "start_date"
    t.integer  "judge_id"
    t.boolean  "players_in", default: false
    t.boolean  "playing",    default: false
    t.string   "won"
  end

  create_table "individual_messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "message"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "obstacles", force: :cascade do |t|
    t.decimal  "latitude",   precision: 8, scale: 6
    t.decimal  "longitude",  precision: 9, scale: 6
    t.integer  "type"
    t.integer  "game_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "pin"
  end

  create_table "team_messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "count"
    t.integer  "game_id"
    t.decimal  "latitude",   precision: 8, scale: 6
    t.decimal  "longitude",  precision: 9, scale: 6
    t.integer  "score",                              default: 0
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "active",                             default: true
  end

  create_table "user_statistics", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "duration_alive"
    t.boolean  "died"
    t.boolean  "won"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "username",                                                null: false
    t.string   "password_digest",                                         null: false
    t.uuid     "access_token",                                            null: false
    t.integer  "role",                                                    null: false
    t.boolean  "active",                                                  null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.integer  "game_id"
    t.integer  "team_id"
    t.boolean  "ready",                                   default: false
    t.decimal  "latitude",        precision: 8, scale: 6
    t.decimal  "longitude",       precision: 9, scale: 6
    t.boolean  "alive",                                   default: true
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
