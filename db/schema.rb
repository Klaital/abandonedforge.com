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

ActiveRecord::Schema.define(version: 20161004202444) do

  create_table "image_tags", force: :cascade do |t|
    t.integer  "image_id"
    t.string   "tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_image_tags_on_image_id"
  end

  create_table "images", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "title"
    t.string   "fullsize_url"
    t.string   "small_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["product_id"], name: "index_images_on_product_id"
  end

  create_table "product_materials", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "name"
    t.string   "material"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["product_id"], name: "index_product_materials_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "thumbnail_url"
    t.string   "description"
    t.string   "slug"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["slug"], name: "index_products_on_slug", unique: true
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
