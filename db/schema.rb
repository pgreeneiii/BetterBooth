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

ActiveRecord::Schema.define(version: 20171117022405) do

  create_table "classes", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "professor_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer  "course_number"
    t.string   "course_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "subject"
  end

  create_table "day_tables", force: :cascade do |t|
    t.string   "day_output"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer  "section_id"
    t.float    "avg_hours"
    t.float    "communication"
    t.float    "engagement"
    t.float    "practical"
    t.float    "learning"
    t.float    "recommendation"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "p1_bid_min"
    t.integer  "p1_bid_max"
    t.integer  "p2_bid_min"
    t.integer  "p2_bid_max"
    t.integer  "p3_bid_min"
    t.integer  "p3_bid_max"
    t.integer  "p4_bid_min"
    t.integer  "p4_bid_max"
  end

  create_table "professors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "section_id"
    t.string   "section_number"
    t.integer  "quarter"
    t.integer  "day"
    t.integer  "time"
    t.boolean  "half_credit"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "professor_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "time_tables", force: :cascade do |t|
    t.string   "time_output"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
