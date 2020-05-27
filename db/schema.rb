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

ActiveRecord::Schema.define(version: 2020_05_27_023049) do

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "campaigns", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.string "name"
    t.string "tag"
    t.integer "segmentation_size"
    t.integer "delivered"
    t.string "title"
    t.text "body"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "impressions", default: 0
    t.integer "clicks", default: 0
    t.datetime "release_date", default: "2020-05-24 23:34:31", null: false
    t.index ["shop_id"], name: "index_campaigns_on_shop_id"
  end

  create_table "configurations", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.boolean "enable_timer", default: false, null: false
    t.boolean "enable_url", default: false, null: false
    t.boolean "enable_pages", default: false, null: false
    t.boolean "and", default: false, null: false
    t.string "modal_text", default: "Do you want to install our app for exclusive promotions?", null: false
    t.integer "timer", default: 20000, null: false
    t.string "url", default: "/", null: false
    t.integer "pages", default: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_id"], name: "index_configurations_on_shop_id"
  end

  create_table "customers", force: :cascade do |t|
    t.boolean "acceptsMarketing"
    t.string "displayName"
    t.string "email"
    t.string "firstName"
    t.string "shopify_id"
    t.string "lastName"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "manifests", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.string "name", default: "O seu App"
    t.string "short_name", default: "App"
    t.string "theme_color", default: "#ffffff"
    t.string "background_color", default: "#000000"
    t.string "display", default: "standalone"
    t.string "orientation", default: "portrait"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "start_url", default: "/?utm_source=homescreen"
    t.string "lang", default: "pt-BR"
    t.string "description", default: "Descrição do seu app aqui"
    t.index ["shop_id"], name: "index_manifests_on_shop_id"
  end

  create_table "optins", force: :cascade do |t|
    t.string "title", default: "Would you like to receive notifications?", null: false
    t.string "body", default: "We can send you special promotions", null: false
    t.string "accept_button", default: "Yes", null: false
    t.string "decline_button", default: "No", null: false
    t.string "background_color", default: "FFFFFF", null: false
    t.string "text_color", default: "000000", null: false
    t.integer "timer", default: 20, null: false
    t.boolean "enabled", default: true, null: false
    t.integer "kind", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "push_interactions", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.date "date"
    t.integer "count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_id"], name: "index_push_interactions_on_shop_id"
  end

  create_table "push_subscriber_campaigns", force: :cascade do |t|
    t.bigint "push_id", null: false
    t.bigint "campaign_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id"], name: "index_push_subscriber_campaigns_on_campaign_id"
    t.index ["push_id"], name: "index_push_subscriber_campaigns_on_push_id"
  end

  create_table "pushes", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "endpoint"
    t.string "auth"
    t.string "p256dh"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "shop_id"
    t.string "subscriber_id"
    t.index ["customer_id"], name: "index_pushes_on_customer_id"
    t.index ["shop_id"], name: "index_pushes_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "domain"
    t.integer "push_limit", default: 200
    t.integer "plan_name", default: 0
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "subscriber_counts", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.integer "service"
    t.integer "count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date", default: -> { "CURRENT_DATE" }
    t.index ["shop_id"], name: "index_subscriber_counts_on_shop_id"
  end

  create_table "track_installs", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "date"
    t.index ["shop_id"], name: "index_track_installs_on_shop_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "campaigns", "shops"
  add_foreign_key "configurations", "shops"
  add_foreign_key "manifests", "shops"
  add_foreign_key "push_interactions", "shops"
  add_foreign_key "push_subscriber_campaigns", "campaigns"
  add_foreign_key "push_subscriber_campaigns", "pushes"
  add_foreign_key "pushes", "customers"
  add_foreign_key "subscriber_counts", "shops"
  add_foreign_key "track_installs", "shops"
end
