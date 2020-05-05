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

ActiveRecord::Schema.define(version: 2018_12_12_023116) do

  create_table "bookings", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "number_people"
    t.integer "user_id"
    t.integer "tour_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id", "created_at"], name: "index_bookings_on_tour_id_and_created_at"
    t.index ["tour_id"], name: "index_bookings_on_tour_id"
    t.index ["user_id", "created_at"], name: "index_bookings_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_categories_on_lft"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["rgt"], name: "index_categories_on_rgt"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.integer "children_count", default: 0, null: false
    t.integer "user_id"
    t.integer "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_comments_on_lft"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["review_id", "created_at"], name: "index_comments_on_review_id_and_created_at"
    t.index ["review_id"], name: "index_comments_on_review_id"
    t.index ["rgt"], name: "index_comments_on_rgt"
    t.index ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "images", force: :cascade do |t|
    t.string "image_link"
    t.integer "tour_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id", "created_at"], name: "index_images_on_tour_id_and_created_at"
    t.index ["tour_id"], name: "index_images_on_tour_id"
  end

  create_table "likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "review_id"
    t.index ["review_id", "created_at"], name: "index_likes_on_review_id_and_created_at"
    t.index ["review_id"], name: "index_likes_on_review_id"
    t.index ["user_id", "created_at"], name: "index_likes_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "user_id"
    t.integer "tour_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tour_id", "created_at"], name: "index_reviews_on_tour_id_and_created_at"
    t.index ["tour_id"], name: "index_reviews_on_tour_id"
    t.index ["user_id", "created_at"], name: "index_reviews_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tours", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.string "name"
    t.date "date_from"
    t.date "date_to"
    t.string "location_from"
    t.string "location_to"
    t.float "price"
    t.integer "max_people"
    t.integer "min_people"
    t.text "description"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "created_at"], name: "index_tours_on_category_id_and_created_at"
    t.index ["category_id"], name: "index_tours_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.boolean "is_admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
