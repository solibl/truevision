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

ActiveRecord::Schema[7.0].define(version: 2023_09_14_220654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clone_feed_schedules", force: :cascade do |t|
    t.integer "clone_feed_plant_number"
    t.integer "clone_feed_day"
    t.integer "minimum_feed_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clone_feeds", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.datetime "date", precision: nil
    t.decimal "clone_feed_ph", precision: 10, scale: 2
    t.decimal "clone_feed_ec", precision: 10, scale: 2
    t.integer "volume_per_tray"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_clone_feeds_on_location_id"
    t.index ["user_id"], name: "index_clone_feeds_on_user_id"
  end

  create_table "data_entries", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "location_id"
    t.bigint "data_sheet_id"
    t.datetime "date", precision: nil
    t.integer "day_count"
    t.string "shift"
    t.integer "weight"
    t.integer "gram_difference"
    t.boolean "fed", default: false
    t.decimal "clone_feed_ph"
    t.decimal "clone_feed_ec"
    t.integer "weight_after_feed"
    t.boolean "has_hood", default: true
    t.boolean "grown_roots", default: false
    t.boolean "grown_roots_less_than_inch", default: false
    t.boolean "grown_roots_greater_than_inch", default: false
    t.boolean "marked_for_outlier", default: false
    t.integer "number_of_plants_killed"
    t.boolean "manual_feed", default: false
    t.text "note"
    t.string "edited_user_initials"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_sheet_id"], name: "index_data_entries_on_data_sheet_id"
    t.index ["location_id"], name: "index_data_entries_on_location_id"
    t.index ["user_id"], name: "index_data_entries_on_user_id"
  end

  create_table "data_sheets", force: :cascade do |t|
    t.bigint "storage_rack_id"
    t.bigint "tray_id"
    t.bigint "location_id"
    t.bigint "strain_id"
    t.bigint "root_rating_id"
    t.boolean "current", default: true
    t.string "status"
    t.integer "starting_total_clone_number"
    t.integer "initial_soak_weight"
    t.integer "total_clone_count"
    t.integer "ending_clone_total_number"
    t.integer "first_initial_dry_back"
    t.integer "first_initial_dry_back_day_count"
    t.integer "average_gram_difference"
    t.integer "first_day_roots"
    t.decimal "success_rate"
    t.boolean "marked_for_outlier", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_data_sheets_on_location_id"
    t.index ["root_rating_id"], name: "index_data_sheets_on_root_rating_id"
    t.index ["storage_rack_id"], name: "index_data_sheets_on_storage_rack_id"
    t.index ["strain_id"], name: "index_data_sheets_on_strain_id"
    t.index ["tray_id"], name: "index_data_sheets_on_tray_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.integer "trays_per_storage_row"
    t.integer "entry_per_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_rack"
    t.integer "total_tray_per_rack"
    t.integer "total_hood_days"
  end

  create_table "root_ratings", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "storage_racks", force: :cascade do |t|
    t.bigint "location_id"
    t.string "name"
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_storage_racks_on_location_id"
  end

  create_table "strains", force: :cascade do |t|
    t.string "name"
    t.integer "best_average_initial_dryback"
    t.integer "best_average_gram_difference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trays", force: :cascade do |t|
    t.bigint "storage_rack_id"
    t.bigint "location_id"
    t.string "name"
    t.boolean "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_trays_on_location_id"
    t.index ["storage_rack_id"], name: "index_trays_on_storage_rack_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "location_id"
    t.string "first_name"
    t.string "last_name"
    t.string "authorization_level"
    t.string "initials"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clone_feeds", "locations"
  add_foreign_key "clone_feeds", "users"
  add_foreign_key "data_entries", "data_sheets"
  add_foreign_key "data_entries", "locations"
  add_foreign_key "data_entries", "users"
  add_foreign_key "data_sheets", "locations"
  add_foreign_key "data_sheets", "root_ratings"
  add_foreign_key "data_sheets", "storage_racks"
  add_foreign_key "data_sheets", "strains"
  add_foreign_key "data_sheets", "trays"
  add_foreign_key "storage_racks", "locations"
  add_foreign_key "trays", "locations"
  add_foreign_key "trays", "storage_racks"
  add_foreign_key "users", "locations"
end
