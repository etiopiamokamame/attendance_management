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

ActiveRecord::Schema.define(version: 20160304151736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.integer  "year"
    t.integer  "month"
    t.string   "site_start_time"
    t.string   "site_end_time"
    t.string   "details"
    t.integer  "lock_version",    default: 0,     null: false
    t.boolean  "deleted",         default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "leave_types", force: :cascade do |t|
    t.string   "content"
    t.integer  "lock_version", default: 0,     null: false
    t.boolean  "deleted",      default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "reasons", force: :cascade do |t|
    t.string   "content"
    t.integer  "lock_version", default: 0,     null: false
    t.boolean  "deleted",      default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "system_configs", force: :cascade do |t|
    t.string   "company_name"
    t.string   "base_working_start_time"
    t.string   "base_working_end_time"
    t.string   "rest_start_time"
    t.string   "rest_end_time"
    t.string   "base_overtime_rest_start_time"
    t.string   "base_overtime_rest_end_time"
    t.string   "late_night_time"
    t.float    "time_off_hours_prospect"
    t.integer  "lock_version",                  default: 0,     null: false
    t.boolean  "deleted",                       default: false, null: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.boolean  "admin",                      default: false, null: false
    t.string   "name"
    t.string   "affiliation_name"
    t.string   "number"
    t.string   "password"
    t.integer  "last_year_paid_holiday"
    t.integer  "current_year_paid_holiday"
    t.integer  "remaining_transfer_holiday"
    t.integer  "lock_version",               default: 0,     null: false
    t.boolean  "deleted",                    default: false, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "working_reports", force: :cascade do |t|
    t.integer  "user_id",                         null: false
    t.integer  "fiscal_year"
    t.integer  "month"
    t.string   "working_time"
    t.string   "off_hours_time"
    t.string   "late_night_time"
    t.string   "shortfall_time"
    t.integer  "lock_version",    default: 0,     null: false
    t.boolean  "deleted",         default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
