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

ActiveRecord::Schema.define(version: 2023_01_08_212147) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contributors", force: :cascade do |t|
    t.string "name"
    t.bigint "repo_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["repo_id"], name: "index_contributors_on_repo_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.string "title"
    t.string "state"
    t.bigint "repo_id"
    t.bigint "user_id"
    t.datetime "merged_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["repo_id"], name: "index_pull_requests_on_repo_id"
    t.index ["user_id"], name: "index_pull_requests_on_user_id"
  end

  create_table "remotes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "repos", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_repos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.bigint "remotes_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["remotes_id"], name: "index_users_on_remotes_id"
  end

  add_foreign_key "contributors", "repos"
  add_foreign_key "pull_requests", "repos"
  add_foreign_key "pull_requests", "users"
  add_foreign_key "repos", "users"
  add_foreign_key "users", "remotes", column: "remotes_id"
end
