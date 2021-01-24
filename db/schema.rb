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

ActiveRecord::Schema.define(version: 2021_01_23_235216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.bigint "school_id", null: false
    t.text "recipient_ids", default: [], array: true
    t.text "gifts", default: [], array: true
    t.integer "status", limit: 2
    t.boolean "notify_delivery"
    t.datetime "cancelled_at"
    t.datetime "received_at"
    t.datetime "shipped_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cancelled_at"], name: "index_orders_on_cancelled_at"
    t.index ["received_at"], name: "index_orders_on_received_at"
    t.index ["school_id"], name: "index_orders_on_school_id"
    t.index ["shipped_at"], name: "index_orders_on_shipped_at"
  end

  create_table "recipients", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "school_id"
    t.index ["school_id"], name: "index_recipients_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "orders", "schools"
  add_foreign_key "recipients", "schools"
end
