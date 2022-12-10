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

ActiveRecord::Schema[7.0].define(version: 2022_11_28_140735) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "office_clients", force: :cascade do |t|
    t.bigint "staff_id", null: false
    t.string "name", null: false, comment: "事業所利用者名"
    t.integer "age", null: false, comment: "年齢"
    t.string "furigana", null: false, comment: "名前のふりがな"
    t.string "postal", null: false, comment: "郵便番号"
    t.string "address", null: false, comment: "住所"
    t.string "family", null: false, comment: "家族情報"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["staff_id"], name: "index_office_clients_on_staff_id"
  end

  create_table "office_images", force: :cascade do |t|
    t.bigint "office_id", null: false
    t.string "caption"
    t.integer "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_id"], name: "index_office_images_on_office_id"
  end

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

  create_table "reserves", force: :cascade do |t|
    t.bigint "office_id", null: false
    t.bigint "client_id", null: false
    t.datetime "interview_begin_at", null: false, comment: "面談開始時間"
    t.datetime "interview_end_at", null: false, comment: "面談終了時間"
    t.string "user_name", null: false, comment: "予約者の名前"
    t.integer "user_age", null: false, comment: "予約者の年齢"
    t.string "contact_tel", null: false, comment: "予約者の電話番号"
    t.text "note", comment: "予約者の困り事"
    t.boolean "is_contacted", default: false, comment: "事業者側が予約者に連絡を取っていたらTRUE"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_reserves_on_client_id"
    t.index ["office_id"], name: "index_reserves_on_office_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.bigint "office_id", null: false
    t.string "name", null: false, comment: "スタッフの名前"
    t.string "furigana", null: false, comment: "スタッフの名前の読み仮名"
    t.text "introduction", comment: "スタッフの紹介文"
    t.integer "role", default: 0, comment: "スタッフの役職をenumで管理する"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["office_id"], name: "index_staffs_on_office_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "office_clients", "staffs"
  add_foreign_key "office_images", "offices"
  add_foreign_key "office_overviews", "offices"
  add_foreign_key "offices", "users", column: "manager_id"
  add_foreign_key "reserves", "offices"
  add_foreign_key "reserves", "users", column: "client_id"
  add_foreign_key "staffs", "offices"
end
