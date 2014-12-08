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

ActiveRecord::Schema.define(version: 20141203012726) do

  create_table "contents", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text"
    t.string   "identifier"
  end

  create_table "contents_pages", id: false, force: true do |t|
    t.integer "content_id", null: false
    t.integer "page_id",    null: false
  end

  create_table "events", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "date"
    t.time     "string"
    t.string   "time"
    t.string   "flyer"
    t.string   "description",  default: ""
    t.string   "facebook_id"
    t.string   "venue"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "price"
    t.string   "ticket_limit"
    t.string   "tickets_sold"
  end

  create_table "graphics", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "identifier"
    t.string   "path"
    t.string   "image"
  end

  create_table "graphics_pages", id: false, force: true do |t|
    t.integer "graphic_id", null: false
    t.integer "page_id",    null: false
  end

  create_table "pages", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "controller"
    t.string   "action"
  end

  create_table "purchases", force: true do |t|
    t.string   "amount"
    t.string   "quantity"
    t.string   "email"
    t.string   "lastfour"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conf_num"
    t.integer  "event_id"
  end

  add_index "purchases", ["event_id"], name: "index_purchases_on_event_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end