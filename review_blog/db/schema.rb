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

ActiveRecord::Schema[8.1].define(version: 2025_12_04_052423) do
  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "review_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["review_id"], name: "index_comments_on_review_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.string "creator_name"
    t.string "image_url"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "review_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "review_id", null: false
    t.integer "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_review_tags_on_review_id"
    t.index ["tag_id"], name: "index_review_tags_on_tag_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.integer "item_id", null: false
    t.integer "rating"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["item_id"], name: "index_reviews_on_item_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password"
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "comments", "reviews"
  add_foreign_key "comments", "users"
  add_foreign_key "items", "categories"
  add_foreign_key "review_tags", "reviews"
  add_foreign_key "review_tags", "tags"
  add_foreign_key "reviews", "items"
  add_foreign_key "reviews", "users"
end
