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

ActiveRecord::Schema.define(version: 2018_05_24_153008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "change_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.integer "priority"
  end

  create_table "release_note_items", force: :cascade do |t|
    t.integer "user_id"
    t.integer "release_note_id"
    t.string "change_title"
    t.text "change_details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "change_type_id"
  end

  create_table "release_notes", force: :cascade do |t|
    t.integer "user_id"
    t.date "release_date"
    t.string "title"
    t.text "intro"
    t.text "outro"
    t.boolean "published", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved", default: false, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "job_title"
    t.boolean "dev", default: false
    t.string "nickname"
    t.integer "preferred_name", default: 0
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
