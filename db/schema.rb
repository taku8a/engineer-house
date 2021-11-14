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

ActiveRecord::Schema.define(version: 2021_11_14_134030) do

  create_table "contacts", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genre_details", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "body", default: "", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_comment_genre_details", force: :cascade do |t|
    t.integer "post_comment_id", null: false
    t.integer "genre_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_comments", force: :cascade do |t|
    t.text "comment", default: "", null: false
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_genre_details", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "genre_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "post_genres", force: :cascade do |t|
    t.integer "post_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", default: "", null: false
    t.text "body", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_chats", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.text "chat", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_members", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.text "introduction", default: "", null: false
    t.integer "owner_id", null: false
    t.string "project_image_id", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "is_valid", default: true, null: false
    t.string "name", default: "", null: false
    t.string "profile_image_id", default: "", null: false
    t.text "introduction", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
