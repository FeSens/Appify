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

ActiveRecord::Schema.define(version: 2021_06_09_194748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
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
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "automation_block_links", force: :cascade do |t|
    t.bigint "automation_block_id", null: false
    t.bigint "push_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["automation_block_id"], name: "index_automation_block_links_on_automation_block_id"
    t.index ["push_id"], name: "index_automation_block_links_on_push_id"
  end

  create_table "automation_blocks", force: :cascade do |t|
    t.bigint "_next_id"
    t.bigint "_prev_id"
    t.bigint "campaign_id"
    t.bigint "shop_id", null: false
    t.integer "count", default: 0
    t.datetime "run_by"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "settings"
    t.bigint "flow_chart_id", null: false
    t.index ["campaign_id"], name: "index_automation_blocks_on_campaign_id"
    t.index ["flow_chart_id"], name: "index_automation_blocks_on_flow_chart_id"
    t.index ["shop_id"], name: "index_automation_blocks_on_shop_id"
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
    t.datetime "release_date", default: "2021-03-07 00:10:14", null: false
    t.index ["shop_id"], name: "index_campaigns_on_shop_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "push_id"
    t.string "token"
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "abandoned", default: true
    t.bigint "shop_id"
    t.string "hexdigest"
    t.string "utm_medium"
    t.string "utm_campaign"
    t.string "utm_source"
    t.boolean "impacted", default: false
    t.index ["customer_id"], name: "index_carts_on_customer_id"
    t.index ["push_id"], name: "index_carts_on_push_id"
    t.index ["shop_id"], name: "index_carts_on_shop_id"
  end

  create_table "checkouts", force: :cascade do |t|
    t.string "subscriber_id", null: false
    t.string "checkout_id"
    t.string "utm_campaign"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "configurations", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.boolean "enable_timer", default: false, null: false
    t.boolean "enable_url", default: false, null: false
    t.boolean "enable_pages", default: false, null: false
    t.boolean "and", default: false, null: false
    t.string "modal_text", default: "Você quer instalar o nosso app para promoçōes exclusuivas?", null: false
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

  create_table "flow_charts", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.jsonb "chart_metadata"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_id"], name: "index_flow_charts_on_shop_id"
  end

  create_table "manifests", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.string "name", default: "O nome da sua loja"
    t.string "short_name", default: "O nome do seu app"
    t.string "theme_color", default: "CB505A"
    t.string "background_color", default: "FFFFFF"
    t.string "display", default: "standalone"
    t.string "orientation", default: "portrait"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "start_url", default: "/?ref=aplicatify&utm_source=aplicatify&utm_medium=app&utm_campaign=app"
    t.string "lang", default: "pt-BR"
    t.string "description", default: "Powered by Aplicatify"
    t.index ["shop_id"], name: "index_manifests_on_shop_id"
  end

  create_table "marketing_values", force: :cascade do |t|
    t.decimal "cpc"
    t.decimal "cps"
    t.decimal "cpd"
    t.bigint "shop_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_id"], name: "index_marketing_values_on_shop_id"
  end

  create_table "opt_in_counts", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.integer "service"
    t.integer "count", default: 0
    t.date "date", default: -> { "CURRENT_DATE" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "accepted", default: 0
    t.integer "declined", default: 0
    t.index ["shop_id"], name: "index_opt_in_counts_on_shop_id"
  end

  create_table "optins", force: :cascade do |t|
    t.string "title", default: "Procurando por promoçōes especiais?", null: false
    t.string "body", default: "Seja notificado das promoçōes mais quentes!", null: false
    t.string "accept_button", default: "Sim!", null: false
    t.string "decline_button", default: "Não", null: false
    t.string "background_color", default: "007bff", null: false
    t.string "text_color", default: "000000", null: false
    t.integer "timer", default: 30, null: false
    t.boolean "enabled", default: false, null: false
    t.integer "kind", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "shop_id", null: false
    t.index ["shop_id"], name: "index_optins_on_shop_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.bigint "campaign_id"
    t.integer "customer_id"
    t.string "landing_site"
    t.string "name"
    t.decimal "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["campaign_id"], name: "index_orders_on_campaign_id"
    t.index ["shop_id"], name: "index_orders_on_shop_id"
  end

  create_table "page_visits", force: :cascade do |t|
    t.bigint "push_id"
    t.integer "time_spent"
    t.string "path"
    t.string "subscriber_id"
    t.datetime "data"
    t.decimal "price"
    t.boolean "is_available"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "session"
    t.bigint "shop_id", null: false
    t.index ["push_id"], name: "index_page_visits_on_push_id"
    t.index ["shop_id"], name: "index_page_visits_on_shop_id"
    t.index ["subscriber_id"], name: "index_page_visits_on_subscriber_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.integer "trial_days"
    t.integer "capped_amount"
    t.string "terms"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "push_limit"
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
    t.index ["subscriber_id"], name: "index_pushes_on_subscriber_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain"
    t.string "shopify_token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "domain"
    t.integer "push_limit", default: 25000
    t.string "name"
    t.boolean "theme_verified", default: false
    t.datetime "last_auth"
    t.datetime "last_activity"
    t.jsonb "metadata"
    t.string "locale", default: "en"
    t.bigint "plan_id"
    t.string "type", default: "Shop::Shopify"
    t.boolean "active", default: true
    t.string "subdomain"
    t.index ["plan_id"], name: "index_shops_on_plan_id"
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
    t.index ["subdomain"], name: "index_shops_on_subdomain", unique: true
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

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid"
    t.jsonb "credentials"
    t.bigint "shop_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["shop_id"], name: "index_users_on_shop_id"
  end

  create_table "webhooks", force: :cascade do |t|
    t.bigint "shop_id"
    t.string "scope"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "emitter"
    t.index ["shop_id"], name: "index_webhooks_on_shop_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "automation_block_links", "automation_blocks"
  add_foreign_key "automation_block_links", "pushes"
  add_foreign_key "automation_blocks", "campaigns"
  add_foreign_key "automation_blocks", "flow_charts"
  add_foreign_key "automation_blocks", "shops"
  add_foreign_key "campaigns", "shops"
  add_foreign_key "carts", "customers"
  add_foreign_key "carts", "pushes"
  add_foreign_key "carts", "shops"
  add_foreign_key "configurations", "shops"
  add_foreign_key "flow_charts", "shops"
  add_foreign_key "manifests", "shops"
  add_foreign_key "marketing_values", "shops"
  add_foreign_key "opt_in_counts", "shops"
  add_foreign_key "optins", "shops"
  add_foreign_key "orders", "campaigns"
  add_foreign_key "orders", "shops"
  add_foreign_key "page_visits", "pushes"
  add_foreign_key "page_visits", "shops"
  add_foreign_key "push_interactions", "shops"
  add_foreign_key "push_subscriber_campaigns", "campaigns"
  add_foreign_key "push_subscriber_campaigns", "pushes"
  add_foreign_key "pushes", "customers"
  add_foreign_key "shops", "plans"
  add_foreign_key "subscriber_counts", "shops"
  add_foreign_key "users", "shops"
  add_foreign_key "webhooks", "shops"
end
