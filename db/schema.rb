# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_09_02_174527) do
  create_table "consumer_indices", primary_key: ["year", "month"], force: :cascade do |t|
    t.integer "year"
    t.integer "month"
    t.decimal "index"
    t.decimal "previous_year"
    t.decimal "previous_month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["year", "month"], name: "index_consumer_indices_on_year_and_month", unique: true
  end

  create_table "request_logs", force: :cascade do |t|
    t.text "body"
    t.text "data"
    t.text "class_name"
    t.integer "status_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spread_sheets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id"
    t.boolean "public", default: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_spread_sheets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "deactived_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
