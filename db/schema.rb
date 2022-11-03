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

ActiveRecord::Schema[7.0].define(version: 2022_10_29_054602) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "office_overviews", force: :cascade do |t|
    t.bigint "office_id", null: false
    t.string "classify", comment: "類型"
    t.date "opening_date", comment: "開設年月"
    t.integer "room_count", comment: "居室数"
    t.string "requirements", comment: "入居時の要件"
    t.string "shared_facilities", comment: "共用設備"
    t.string "business_entity", comment: "経営・事業主体"
    t.string "official_site_url", comment: "公式サイトのurl"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_id"], name: "index_office_overviews_on_office_id", unique: true
  end

  create_table "offices", force: :cascade do |t|
    t.bigint "manager_id", null: false
    t.string "name", default: "未編集", null: false
    t.string "feature_title", default: "未編集", null: false
    t.text "feature_detail", default: "未編集", null: false
    t.bigint "workday", default: 0, null: false
    t.string "workday_detail", default: "未編集", null: false
    t.decimal "lat", precision: 8, scale: 6
    t.decimal "lng", precision: 9, scale: 6
    t.string "fax", default: "未編集", null: false
    t.string "nearest_station", default: "未編集", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["feature_detail"], name: "index_offices_on_feature_detail"
    t.index ["feature_title"], name: "index_offices_on_feature_title"
    t.index ["lat"], name: "index_offices_on_lat"
    t.index ["lng"], name: "index_offices_on_lng"
    t.index ["manager_id"], name: "index_offices_on_manager_id", unique: true
    t.index ["name"], name: "index_offices_on_name"
    t.index ["nearest_station"], name: "index_offices_on_nearest_station"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "name", null: false
    t.string "email", null: false
    t.string "tel", null: false
    t.string "address", null: false
    t.string "postal", null: false
    t.string "type", null: false
    t.json "tokens"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_users_on_address"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["type"], name: "index_users_on_type"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "office_overviews", "offices"
  add_foreign_key "offices", "users", column: "manager_id"
end
