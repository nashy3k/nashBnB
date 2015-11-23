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

ActiveRecord::Schema.define(version: 201511191032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "token"
    t.string   "secret"
    t.string   "location"
    t.string   "image_url"
    t.string   "url"
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", unique: true, using: :btree
  add_index "authentications", ["provider"], name: "index_authentications_on_provider", using: :btree
  add_index "authentications", ["uid"], name: "index_authentications_on_uid", using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                   null: false
    t.string   "location",                null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "about"
    t.integer  "accomodates"
    t.integer  "bathrooms"
    t.string   "bed_type"
    t.integer  "bedrooms"
    t.integer  "beds"
    t.datetime "check_in"
    t.datetime "check_out"
    t.boolean  "smoking"
    t.boolean  "pets"
    t.boolean  "kitchen"
    t.boolean  "tv"
    t.boolean  "internet"
    t.boolean  "wifi"
    t.boolean  "free_parking"
    t.boolean  "family_friendly"
    t.boolean  "suitable_events"
    t.integer  "prices"
    t.integer  "weekly_discount"
    t.integer  "monthly_discount"
    t.string   "cancellation"
    t.string   "description"
    t.datetime "availability_start_date"
    t.datetime "availability_end_date"
    t.string   "safety_features"
    t.string   "pictures_url"
  end

  add_index "listings", ["location"], name: "index_listings_on_location", using: :btree
  add_index "listings", ["title", "location"], name: "index_listings_on_title_and_location", unique: true, using: :btree
  add_index "listings", ["title"], name: "index_listings_on_title", using: :btree
  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "listing_id",      null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "comments"
    t.integer  "guests"
    t.datetime "check_in_date"
    t.datetime "check_out_date"
    t.boolean  "smoking"
    t.boolean  "pets"
    t.boolean  "kitchen"
    t.boolean  "tv"
    t.boolean  "internet"
    t.boolean  "wifi"
    t.boolean  "free_parking"
    t.boolean  "family_friendly"
    t.boolean  "suitable_events"
  end

  add_index "reservations", ["check_in_date"], name: "index_reservations_on_check_in_date", using: :btree
  add_index "reservations", ["check_out_date"], name: "index_reservations_on_check_out_date", using: :btree
  add_index "reservations", ["listing_id"], name: "index_reservations_on_listing_id", using: :btree
  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name",                           null: false
    t.string   "email",                          null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["first_name"], name: "index_users_on_first_name", using: :btree
  add_index "users", ["last_name"], name: "index_users_on_last_name", using: :btree
  add_index "users", ["name"], name: "index_users_on_name", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
