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

ActiveRecord::Schema.define(version: 2019_09_25_091533) do

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

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "github_check_suites", force: :cascade do |t|
    t.bigint "github_id"
    t.string "head_branch"
    t.string "head_sha"
    t.bigint "github_repository_id"
    t.string "conclusion", default: "neutral"
    t.string "status", default: "queued"
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "install_id"
    t.index ["github_repository_id"], name: "index_github_check_suites_on_github_repository_id"
    t.index ["install_id"], name: "index_github_check_suites_on_install_id"
  end

  create_table "github_repositories", force: :cascade do |t|
    t.bigint "github_id"
    t.string "name"
    t.string "full_name"
    t.boolean "private", default: false
    t.bigint "install_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["install_id"], name: "index_github_repositories_on_install_id"
    t.index ["project_id"], name: "index_github_repositories_on_project_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "provider", default: "github"
    t.string "uid"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_identities_on_provider_and_uid"
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "installs", force: :cascade do |t|
    t.string "account_login"
    t.integer "app_id"
    t.integer "install_id"
    t.integer "installs_users_count", default: 0
    t.integer "projects_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installs_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "install_id"
    t.string "role", default: "owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["install_id"], name: "index_installs_users_on_install_id"
    t.index ["user_id", "install_id"], name: "index_installs_users_on_user_id_and_install_id"
    t.index ["user_id"], name: "index_installs_users_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "full_name"
    t.string "api_key"
    t.string "default_branch", default: "master"
    t.boolean "private", default: false
    t.bigint "install_id"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_analysed_at"
    t.integer "database_request_max", default: 35, null: false
    t.integer "request_time_max", default: 250, null: false
    t.bigint "memory_max_in_bytes", default: 367001600, null: false
    t.index ["api_key"], name: "index_projects_on_api_key", unique: true
    t.index ["install_id"], name: "index_projects_on_install_id"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "report_collections", force: :cascade do |t|
    t.string "commit_sha1"
    t.datetime "last_analysed_at"
    t.string "branch", default: "master"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "conclusion", default: "neutral"
    t.index ["project_id"], name: "index_report_collections_on_project_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "report_collection_id"
    t.bigint "project_id"
    t.decimal "max", precision: 14, default: "0"
    t.decimal "max_difference_from_default_branch", default: "0.0"
    t.decimal "min", precision: 14, default: "0"
    t.decimal "min_difference_from_default_branch", default: "0.0"
    t.decimal "total_requests", default: "0.0"
    t.datetime "analysed_at"
    t.string "profiler", default: "memory"
    t.string "branch", default: "master"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "conclusion", default: "neutral"
    t.index ["project_id"], name: "index_reports_on_project_id"
    t.index ["report_collection_id"], name: "index_reports_on_report_collection_id"
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "github_check_suites", "github_repositories"
  add_foreign_key "github_repositories", "installs"
  add_foreign_key "github_repositories", "projects"
  add_foreign_key "identities", "users"
  add_foreign_key "installs_users", "installs"
  add_foreign_key "installs_users", "users"
  add_foreign_key "projects", "installs"
  add_foreign_key "report_collections", "projects"
  add_foreign_key "reports", "projects"
  add_foreign_key "reports", "report_collections"
end
