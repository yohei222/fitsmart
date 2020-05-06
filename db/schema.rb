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

ActiveRecord::Schema.define(version: 2020_05_06_142831) do

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "micropost_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id"], name: "index_comments_on_micropost_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "exercises", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", default: 0
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "micropost_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["micropost_id"], name: "index_likes_on_micropost_id"
    t.index ["user_id", "micropost_id"], name: "index_likes_on_user_id_and_micropost_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "microposts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likes_count", default: 0, null: false
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "records", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "micropost_id"
    t.integer "exercise_id"
    t.integer "weight"
    t.integer "times"
    t.integer "sets"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_records_on_exercise_id"
    t.index ["micropost_id"], name: "index_records_on_micropost_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "status", limit: 1, default: 1, null: false
    t.integer "sex", limit: 2, default: 2
    t.string "email"
    t.string "name"
    t.string "image"
    t.boolean "admin", default: false
    t.string "remember_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "microposts"
  add_foreign_key "comments", "users"
  add_foreign_key "microposts", "users"
  add_foreign_key "records", "microposts"
end
