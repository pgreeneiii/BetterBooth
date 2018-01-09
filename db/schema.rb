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

ActiveRecord::Schema.define(version: 20180108233206) do

  create_table "bids", force: :cascade do |t|
    t.integer  "section_id"
    t.integer  "quarter_id"
    t.integer  "year"
    t.integer  "day_id"
    t.integer  "time_id"
    t.integer  "p1_price"
    t.integer  "p2_price"
    t.integer  "p3_price"
    t.integer  "p4_price"
    t.integer  "new_student_p1_price"
    t.integer  "new_student_p2_price"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

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

  create_table "quarter_tables", force: :cascade do |t|
    t.string   "quarter_output"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "section_id"
    t.integer  "quarter_id"
    t.integer  "year"
    t.string   "section_number"
    t.integer  "responses"
    t.integer  "enrollment"
    t.float    "avg_hours"
    t.float    "comms_mean"
    t.float    "engaging_mean"
    t.float    "practical_mean"
    t.float    "amt_learned_mean"
    t.float    "recommend_mean"
    t.integer  "comms_median"
    t.integer  "engaging_median"
    t.integer  "practical_median"
    t.integer  "amt_learned_median"
    t.integer  "recommend_median"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
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
    t.text     "content"
  end

  create_table "time_tables", force: :cascade do |t|
    t.string   "time_output"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "username"
    t.string   "avatar_url"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
