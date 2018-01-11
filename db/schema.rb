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

ActiveRecord::Schema.define(version: 20180105173748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bid_autos", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bid_histories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blocked_product_lists", force: :cascade do |t|
    t.integer "blocked_product_id"
    t.integer "accepter_blocked_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blocked_user_lists", force: :cascade do |t|
    t.integer "blocked_user_id"
    t.integer "accepter_blocked_user_id"
    t.datetime "ending_date"
    t.integer "block_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "category_product_lists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "product_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "following_users", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.text "content"
    t.string "typee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "multi_languages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "product_id"
    t.integer "order_id"
    t.integer "unit_price"
    t.integer "quantity"
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer "subtotal"
    t.integer "tax"
    t.integer "shipping"
    t.integer "total"
    t.integer "order_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photo_lists", force: :cascade do |t|
    t.integer "type", null: false
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer "photo_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.boolean "is_multi_language"
    t.integer "buy_now_price"
    t.integer "starting_price"
    t.integer "current_price"
    t.integer "rising_price"
    t.integer "hours_to_bid"
    t.integer "max_price"
    t.integer "winner"
    t.string "status"
    t.string "reason"
    t.string "category"
    t.integer "seller_id"
    t.integer "accepter_id"
    t.datetime "accepted_time"
    t.datetime "end_time"
    t.boolean "can_edit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reported_product_lists", force: :cascade do |t|
    t.integer "reported_product_id"
    t.integer "reporter_id"
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reported_user_lists", force: :cascade do |t|
    t.integer "reported_user_id"
    t.integer "reporter_id"
    t.text "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "password_digest"
    t.string "name"
    t.string "typee"
    t.string "status"
    t.string "email"
    t.string "phone_number"
    t.string "address"
    t.integer "posted_this_month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_vip"
    t.string "avatar"
  end

  create_table "vip_lists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.date "ending_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "blocked_product_lists", "products", column: "blocked_product_id", name: "fk_blocked_product"
  add_foreign_key "blocked_user_lists", "users", column: "blocked_user_id", name: "fk_blocked_user"
  add_foreign_key "following_users", "users", column: "followed_id", name: "fk_users_following_2"
  add_foreign_key "following_users", "users", name: "fk_users_following_1"
  add_foreign_key "photos", "photo_lists", name: "fk_photo_photo_list"
  add_foreign_key "products", "users", column: "seller_id", name: "fk_users_products"
  add_foreign_key "reported_product_lists", "products", column: "reported_product_id", name: "fk_reported_product"
  add_foreign_key "reported_product_lists", "users", column: "reporter_id", name: "fk_reported_user"
  add_foreign_key "reported_user_lists", "users", column: "reported_user_id", name: "fk_reported_user1"
  add_foreign_key "reported_user_lists", "users", column: "reporter_id", name: "fk_reported_user2"
  add_foreign_key "vip_lists", "users"
end
