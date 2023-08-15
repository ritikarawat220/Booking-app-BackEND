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

ActiveRecord::Schema[7.0].define(version: 2023_08_14_180713) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aeroplanes", force: :cascade do |t|
    t.string "name"
    t.string "model"
    t.text "description"
    t.decimal "price"
    t.decimal "booking_price"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "reservation_date"
    t.date "returning_date"
    t.string "city"
    t.bigint "user_id", null: false
    t.bigint "aeroplane_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aeroplane_id"], name: "index_reservations_on_aeroplane_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "reservations", "aeroplanes"
  add_foreign_key "reservations", "users"
end
