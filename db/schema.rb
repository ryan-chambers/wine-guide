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

ActiveRecord::Schema.define(version: 2022_01_01_161947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bottles", id: :serial, force: :cascade do |t|
    t.date "reviewdate"
    t.float "score"
    t.text "comments"
    t.integer "wine_id"
    t.float "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "drink_to"
    t.integer "drink_from"
    t.boolean "in_fridge"
    t.string "bought"
    t.string "review_day_of_year"
    t.index ["wine_id"], name: "index_bottles_on_wine_id"
  end

  create_table "grapes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grapes_wines", id: false, force: :cascade do |t|
    t.integer "grape_id"
    t.integer "wine_id"
  end

  create_table "wineries", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wines", id: :serial, force: :cascade do |t|
    t.string "region"
    t.string "country"
    t.string "other"
    t.integer "year"
    t.integer "winery_id"
    t.string "lcbo_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "grape_id"
    t.index ["grape_id"], name: "index_wines_on_grape_id"
  end

  add_foreign_key "wines", "grapes"
end
