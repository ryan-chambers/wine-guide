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

ActiveRecord::Schema.define(version: 2019_08_27_191009) do

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
  end

end
