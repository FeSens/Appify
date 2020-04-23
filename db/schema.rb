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

ActiveRecord::Schema.define(version: 2020_04_23_005736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.string "start_url", default: "/"
    t.string "lang", default: "pt-BR"
    t.string "description", default: "Descrição do seu app aqui"
    t.index ["shop_id"], name: "index_manifests_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "domain"
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  add_foreign_key "manifests", "shops"
end
