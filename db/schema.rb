# frozen_string_literal: true

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

ActiveRecord::Schema[7.2].define(version: 2024_12_23_133046) do
  create_table "collections", force: :cascade do |t|
    t.string("user_settings")
    t.string("collectable_type", null: false)
    t.integer("collectable_id", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["collectable_type", "collectable_id"], name: "index_collections_on_collectable")
  end

  create_table "consumer_indices", primary_key: ["year", "month"], force: :cascade do |t|
    t.integer("year")
    t.integer("month")
    t.decimal("index")
    t.decimal("previous_year")
    t.decimal("previous_month")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["year", "month"], name: "index_consumer_indices_on_year_and_month", unique: true)
  end

  create_table "living_units", force: :cascade do |t|
    t.string("name")
    t.text("description")
    t.string("properties")
    t.integer("real_estate_id", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["real_estate_id"], name: "index_living_units_on_real_estate_id")
  end

  create_table "memberships", force: :cascade do |t|
    t.integer("user_id", null: false)
    t.string("role")
    t.string("memberable_type", null: false)
    t.integer("memberable_id", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["memberable_type", "memberable_id"], name: "index_memberships_on_memberable")
    t.index(["user_id"], name: "index_memberships_on_user_id")
  end

  create_table "real_estates", force: :cascade do |t|
    t.string("name")
    t.string("address")
    t.string("properties")
    t.string("heating")
    t.string("solar_plant")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
  end

  create_table "rents", force: :cascade do |t|
    t.decimal("cold_rent", precision: 10, scale: 2, default: "0.0")
    t.decimal("heating_costs", precision: 10, scale: 2, default: "0.0")
    t.decimal("incidental_costs", precision: 10, scale: 2, default: "0.0")
    t.string("rent_type", null: false)
    t.date("valid_from")
    t.integer("living_unit_id", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["living_unit_id"], name: "index_rents_on_living_unit_id")
  end

  create_table "request_logs", force: :cascade do |t|
    t.text("body")
    t.text("data")
    t.text("class_name")
    t.integer("status_code")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
  end

  create_table "tenants", force: :cascade do |t|
    t.string("name")
    t.string("properties")
    t.datetime("start_of_tenancy")
    t.boolean("archived", default: false)
    t.integer("living_unit_id", null: false)
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["living_unit_id"], name: "index_tenants_on_living_unit_id")
  end

  create_table "users", force: :cascade do |t|
    t.string("name")
    t.string("email")
    t.string("password_digest")
    t.datetime("deactived_at")
    t.datetime("created_at", null: false)
    t.datetime("updated_at", null: false)
    t.index(["email"], name: "index_users_on_email", unique: true)
  end

  add_foreign_key "living_units", "real_estates"
  add_foreign_key "memberships", "users"
  add_foreign_key "rents", "living_units"
  add_foreign_key "tenants", "living_units"
end
