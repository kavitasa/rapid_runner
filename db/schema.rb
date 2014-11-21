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

ActiveRecord::Schema.define(version: 20141120212127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "river_state", id: false, force: true do |t|
    t.integer "river_id", null: false
    t.integer "state_id", null: false
  end

  add_index "river_state", ["river_id"], name: "index_river_state_on_river_id", using: :btree
  add_index "river_state", ["state_id"], name: "index_river_state_on_state_id", using: :btree

  create_table "rivers", force: true do |t|
    t.string "name"
  end

  create_table "sections", force: true do |t|
    t.integer  "river_id"
    t.integer  "state_id"
    t.string   "name"
    t.string   "water_class"
    t.decimal  "takeout_long"
    t.decimal  "takeout_lat"
    t.decimal  "putin_long"
    t.decimal  "putin_lat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sections", ["river_id"], name: "index_sections_on_river_id", using: :btree
  add_index "sections", ["state_id"], name: "index_sections_on_state_id", using: :btree

  create_table "states", force: true do |t|
    t.string "name"
    t.string "abbr"
  end

end
