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

ActiveRecord::Schema.define(version: 2019_10_24_205341) do

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
    t.bigint "user_id"
    t.boolean "status", default: true
    t.text "description"
    t.string "title"
    t.string "tags", array: true
    t.string "options", array: true
    t.string "selected_option"
    t.index ["options"], name: "index_offers_on_options", using: :gin
    t.index ["tags"], name: "index_offers_on_tags", using: :gin
    t.index ["user_id"], name: "index_offers_on_user_id"
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
    t.string "keywords", default: [], array: true
    t.text "search_terms"
    t.string "modifiers", array: true
    t.string "tags", array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["modifiers"], name: "index_users_on_modifiers", using: :gin
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tags"], name: "index_users_on_tags", using: :gin
  end

  add_foreign_key "accounts", "items"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "items", "users"
  add_foreign_key "offers", "users"
  add_foreign_key "transactions", "accounts"
end
