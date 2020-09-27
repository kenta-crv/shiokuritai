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

ActiveRecord::Schema.define(version: 2020_09_27_092733) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "company"
    t.string "first_name"
    t.string "last_name"
    t.string "tel_front"
    t.string "tel_middle"
    t.string "tel_back"
    t.string "fax_front"
    t.string "fax_middle"
    t.string "fax_back"
    t.string "postnumber"
    t.string "prefecture"
    t.string "city"
    t.string "town"
    t.string "town_number"
    t.string "building"
    t.string "mail"
    t.string "url"
    t.string "usp"
    t.string "people"
    t.string "image"
    t.string "foundation"
    t.string "handing_business"
    t.string "access"
    t.string "holiday"
    t.string "business_hour"
    t.string "price"
    t.string "explanation"
    t.string "bookmark"
    t.string "company_yomi"
    t.string "name_yomi"
    t.string "title_title"
    t.string "title_image"
    t.string "title_detail"
    t.string "profile_title"
    t.string "profile_image"
    t.string "profile_detail"
    t.string "address_image"
    t.string "address_detail"
    t.string "consultation_fee"
    t.string "commitment"
    t.integer "admin_id"
    t.integer "user_id"
    t.integer "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_companies_on_admin_id"
    t.index ["member_id"], name: "index_companies_on_member_id"
    t.index ["user_id"], name: "index_companies_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "company"
    t.string "name"
    t.string "tel"
    t.string "address"
    t.string "email"
    t.string "subject"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estimates", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "first_kana"
    t.string "last_kana"
    t.string "tel"
    t.string "email"
    t.string "prefecture"
    t.string "city"
    t.string "town"
    t.string "worries"
    t.string "importance"
    t.string "period"
    t.string "remarks"
    t.integer "company_id"
    t.integer "postcode"
    t.integer "prefecture_code"
    t.string "address_city"
    t.string "address_street"
    t.string "address_building"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "send_mail_flag", default: false
    t.index ["company_id"], name: "index_estimates_on_company_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "company"
    t.string "name"
    t.string "tel"
    t.string "fax"
    t.string "postnumber"
    t.string "prefecture"
    t.string "city"
    t.string "town"
    t.string "chome"
    t.string "building"
    t.string "mail"
    t.string "url"
    t.string "usp"
    t.string "caption"
    t.string "people"
    t.string "image"
    t.string "foundation"
    t.string "contact_url"
    t.string "number_of_business"
    t.string "number_of_store"
    t.string "explanation"
    t.string "holiday"
    t.string "business_hour"
    t.string "price"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "access"
    t.string "bookmark"
    t.string "company_yomi"
    t.string "name_yomi"
    t.string "title_title"
    t.string "title_image"
    t.string "title_detail"
    t.string "profile_title"
    t.string "profile_image"
    t.string "profile_detail"
    t.string "address_image"
    t.string "address_detail"
    t.string "consultation_fee"
    t.string "commitment"
    t.integer "worker_id"
    t.index ["admin_id"], name: "index_lists_on_admin_id"
    t.index ["worker_id"], name: "index_lists_on_worker_id"
  end

  create_table "lps", force: :cascade do |t|
    t.string "name"
    t.string "trouble_1"
    t.string "trouble_2"
    t.string "trouble_3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "point", default: 0
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_id"
    t.integer "estimate_id"
    t.text "content"
    t.boolean "is_user"
    t.boolean "is_read", default: false
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.string "file"
    t.string "choice"
    t.string "keyword"
    t.string "description"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "body"
    t.string "genre"
    t.integer "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_questions_on_member_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "member_id", null: false
    t.text "uri_token", null: false
    t.integer "status", default: 0, null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string "store"
    t.string "evaluation"
    t.string "url"
    t.string "tel"
    t.string "address"
    t.string "genre"
    t.string "payment"
    t.string "price_lunch"
    t.string "price_dinner"
    t.string "hour"
    t.string "holiday"
    t.string "budget"
    t.string "price"
    t.string "difficulty"
    t.string "bookking"
    t.string "sit"
    t.string "open"
    t.string "remarks"
    t.string "takeout"
    t.string "image_1"
    t.string "image_2"
    t.string "image_3"
    t.string "image_4"
    t.string "image_5"
    t.string "image_6"
    t.string "image_7"
    t.string "image_8"
    t.string "image_9"
    t.string "image_10"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workers", force: :cascade do |t|
    t.string "user_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_workers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_workers_on_reset_password_token", unique: true
  end

end
