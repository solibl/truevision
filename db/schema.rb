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

ActiveRecord::Schema.define(version: 2021_11_12_231446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clone_feed_days", force: :cascade do |t|
    t.integer "clone_feed_day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clone_feed_days_plant_numbers", id: false, force: :cascade do |t|
    t.bigint "clone_feed_plant_number_id", null: false
    t.bigint "clone_feed_day_id", null: false
    t.integer "minimum_feed_weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clone_feed_plant_numbers", force: :cascade do |t|
    t.string "number_of_clones"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clone_feeds", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.datetime "date"
    t.decimal "clone_feed_ph", precision: 1, scale: 1
    t.decimal "clone_feed_ec", precision: 1, scale: 1
    t.integer "volume_per_tray"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_clone_feeds_on_location_id"
    t.index ["user_id"], name: "index_clone_feeds_on_user_id"
  end

  create_table "data_entries", force: :cascade do |t|
    t.bigint "location_id"
    t.bigint "data_sheet_id"
    t.datetime "date"
    t.integer "day_count"
    t.string "shift"
    t.integer "weight"
    t.integer "gram_difference"
    t.string "fed"
    t.decimal "clone_feed_ph"
    t.decimal "clone_feed_ec"
    t.integer "weight_after_feed"
    t.boolean "has_hood", default: true
    t.boolean "grown_roots", default: false
    t.integer "number_of_plants_killed"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data_sheet_id"], name: "index_data_entries_on_data_sheet_id"
    t.index ["location_id"], name: "index_data_entries_on_location_id"
  end

  create_table "data_sheets", force: :cascade do |t|
    t.bigint "rack_id"
    t.bigint "tray_id"
    t.bigint "location_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_data_sheets_on_location_id"
    t.index ["rack_id"], name: "index_data_sheets_on_rack_id"
    t.index ["tray_id"], name: "index_data_sheets_on_tray_id"
  end

  create_table "data_sheets_strains", id: false, force: :cascade do |t|
    t.bigint "data_sheet_id", null: false
    t.bigint "strain_id", null: false
    t.bigint "root_rating_id"
    t.bigint "location_id"
    t.integer "initial_dry_back"
    t.integer "total_clone_count"
    t.integer "average_gram_difference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_data_sheets_strains_on_location_id"
    t.index ["root_rating_id"], name: "index_data_sheets_strains_on_root_rating_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "racks", force: :cascade do |t|
    t.bigint "location_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_racks_on_location_id"
  end

  create_table "root_ratings", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "strains", force: :cascade do |t|
    t.string "name"
    t.integer "best_average_initial_dryback"
    t.integer "best_average_gram_difference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trays", force: :cascade do |t|
    t.bigint "rack_id"
    t.bigint "location_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_trays_on_location_id"
    t.index ["rack_id"], name: "index_trays_on_rack_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "location_id"
    t.string "name"
    t.string "authorization_level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_users_on_location_id"
  end

  add_foreign_key "clone_feeds", "locations"
  add_foreign_key "clone_feeds", "users"
  add_foreign_key "data_entries", "data_sheets"
  add_foreign_key "data_entries", "locations"
  add_foreign_key "data_sheets", "locations"
  add_foreign_key "data_sheets", "racks"
  add_foreign_key "data_sheets", "trays"
  add_foreign_key "data_sheets_strains", "locations"
  add_foreign_key "data_sheets_strains", "root_ratings"
  add_foreign_key "racks", "locations"
  add_foreign_key "trays", "locations"
  add_foreign_key "trays", "racks"
  add_foreign_key "users", "locations"
end
