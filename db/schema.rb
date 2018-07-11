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

ActiveRecord::Schema.define(version: 20180711034245) do

  create_table "attachments", force: :cascade do |t|
    t.string "name"
    t.string "attachment"
    t.integer "doc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors", force: :cascade do |t|
    t.integer "author_id"
    t.string "name"
    t.string "contact"
    t.string "department"
    t.string "agency"
    t.string "address"
    t.integer "doc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctypes", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.integer "doc_id"
    t.string "name"
    t.string "doc_type"
    t.text "description"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "status"
    t.date "date_modified"
    t.text "author_name"
  end

  create_table "events", force: :cascade do |t|
    t.integer "event_id"
    t.string "event_type"
    t.text "remarks"
    t.integer "doc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "event_date"
  end

  create_table "forwards", force: :cascade do |t|
    t.text "user_id"
    t.text "doc_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "received", default: false
  end

  create_table "jobtitles", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.text "provider"
    t.text "uid"
    t.text "fullname"
    t.text "emailadd"
    t.text "first_name"
    t.text "last_name"
    t.text "password"
    t.text "job_title"
    t.text "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "emailadd"
    t.string "first_name"
    t.string "last_name"
    t.string "password"
    t.string "job_title"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
