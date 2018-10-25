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

ActiveRecord::Schema.define(version: 20180910210753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_request", force: :cascade do |t|
    t.string "email_address"
    t.string "first_name"
    t.string "last_name"
    t.string "organisation"
    t.string "reason"
    t.integer "requester_id"
    t.integer "status"
    t.string "requester_email"
    t.datetime "request_date_utc"
  end

  create_table "course_enrichment", force: :cascade do |t|
    t.string "inst_code"
    t.string "ucas_course_code"
    t.integer "status"
  end

  create_table "institution_enrichment", force: :cascade do |t|
    t.string "inst_code"
    t.integer "status"
  end

  create_table "organisation", force: :cascade do |t|
    t.string "name"
    t.string "org_id"
  end

  create_table "organisation_institution", force: :cascade do |t|
    t.integer "institution_id"
    t.integer "organisation_id"
  end

  create_table "organisation_user", force: :cascade do |t|
    t.integer "organisation_id"
    t.integer "user_id"
  end

  create_table "user", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "sign_in_user_id"
    t.datetime "first_login_date_utc"
    t.datetime "last_login_date_utc"
    t.datetime "welcome_email_date_utc"
  end

  create_table "nctl_organisation", force: :cascade do |t|
    t.integer "organisation_id"
    t.string "nctl_id"
  end

  create_table "course", force: :cascade do |t|
    t.integer "institution_id"
    t.string "course_code"
  end

  create_table "institution", force: :cascade do |t|
    t.string "inst_name"
    t.string "addr1"
    t.string "addr2"
    t.string "addr3"
    t.string "addr4"
    t.string "postcode"
    t.string "scitt"
    t.string "contact_name"
    t.string "year_code"
    t.string "inst_code"
    t.string "inst_type"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
