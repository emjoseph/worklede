# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_03_221846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "jobs", force: :cascade do |t|
    t.string "url"
    t.text "desc"
    t.string "location"
    t.string "title"
    t.string "code"
    t.string "company"
    t.string "platform"
    t.string "category"
    t.string "posted_days_ago_string"
    t.integer "posted_days_ago_int"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "match_id"
    t.index ["code", "company"], name: "index_jobs_on_code_and_company", unique: true
    t.index ["match_id"], name: "index_jobs_on_match_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "resume_id", null: false
    t.bigint "job_id", null: false
    t.boolean "didEmail"
    t.boolean "didEmail2"
    t.string "company"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "score"
    t.index ["job_id"], name: "index_matches_on_job_id"
    t.index ["resume_id"], name: "index_matches_on_resume_id"
  end

  create_table "resumes", force: :cascade do |t|
    t.string "s3_link"
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "s3_txt_link"
    t.text "resume_txt"
    t.index ["user_id"], name: "index_resumes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "image_url"
    t.string "access_token"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "resumes_id"
    t.index ["resumes_id"], name: "index_users_on_resumes_id"
  end

  add_foreign_key "jobs", "matches"
  add_foreign_key "matches", "resumes"
  add_foreign_key "resumes", "users"
  add_foreign_key "users", "resumes", column: "resumes_id"
end
