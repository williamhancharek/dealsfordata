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

ActiveRecord::Schema.define(version: 2019_12_13_051023) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "item_id"
    t.index ["item_id"], name: "index_accounts_on_item_id"
  end

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "box_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["box_id"], name: "index_assignments_on_box_id"
    t.index ["user_id", "box_id"], name: "index_assignments_on_user_id_and_box_id", unique: true
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "boxes", force: :cascade do |t|
    t.string "gender"
    t.float "latitude"
    t.float "longitude"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.text "search_terms"
    t.string "name"
    t.jsonb "keywords", default: "{}", null: false
    t.jsonb "modifiers", default: "{}", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.integer "public", default: 0
    t.jsonb "settings", default: {}, null: false
    t.index ["settings"], name: "index_boxes_on_settings", using: :gin
    t.index ["user_id"], name: "index_boxes_on_user_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.string "name"
    t.index ["user_id"], name: "index_campaigns_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.string "access_token"
    t.string "plaid_item_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "description"
    t.string "title"
    t.string "tags", array: true
    t.string "options", array: true
    t.string "selected_option"
    t.bigint "box_id", null: false
    t.bigint "campaign_id"
    t.string "public_selected_option"
    t.string "public_options", array: true
    t.string "commentary"
    t.bigint "referrer", array: true
    t.string "received_commentary"
    t.bigint "original_offer_id"
    t.boolean "approved", default: false
    t.jsonb "state", default: {}, null: false
    t.index ["box_id"], name: "index_offers_on_box_id"
    t.index ["campaign_id"], name: "index_offers_on_campaign_id"
    t.index ["options"], name: "index_offers_on_options", using: :gin
    t.index ["state"], name: "index_offers_on_state", using: :gin
    t.index ["tags"], name: "index_offers_on_tags", using: :gin
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "subscriber_id", null: false
    t.integer "subscribing_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subscriber_id"], name: "index_subscriptions_on_subscriber_id"
    t.index ["subscribing_id", "subscriber_id"], name: "index_subscriptions_on_subscribing_id_and_subscriber_id", unique: true
    t.index ["subscribing_id"], name: "index_subscriptions_on_subscribing_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id"
    t.float "amount"
    t.string "category"
    t.integer "category_id"
    t.date "date"
    t.string "iso_currency_code"
    t.string "location"
    t.string "name"
    t.hstore "payment_meta"
    t.hstore "payment_location"
    t.boolean "pending"
    t.string "transaction_id"
    t.string "transaction_place"
    t.index ["account_id"], name: "index_transactions_on_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.integer "role", default: 0
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.jsonb "settings", default: {}, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["settings"], name: "index_users_on_settings", using: :gin
  end

  add_foreign_key "accounts", "items"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "boxes", "users"
  add_foreign_key "campaigns", "users"
  add_foreign_key "items", "users"
  add_foreign_key "offers", "boxes"
  add_foreign_key "offers", "campaigns"
  add_foreign_key "transactions", "accounts"
end
