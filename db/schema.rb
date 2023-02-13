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

ActiveRecord::Schema[7.0].define(version: 2023_02_13_145929) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "application_command_types", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "application_commands", force: :cascade do |t|
    t.bigint "discord_application_id", null: false
    t.bigint "application_command_type_id", null: false
    t.string "discord_application_command_id", null: false
    t.string "name", default: "", null: false
    t.jsonb "meta_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_command_type_id"], name: "index_application_commands_on_application_command_type_id"
    t.index ["discord_application_id", "discord_application_command_id"], name: "application_commands_index", unique: true
    t.index ["discord_application_id"], name: "index_application_commands_on_discord_application_id"
  end

  create_table "discord_applications", force: :cascade do |t|
    t.string "discord_application_id", default: "", null: false
    t.string "name", default: "", null: false
    t.jsonb "meta_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guilds", force: :cascade do |t|
    t.string "discord_guild_id", default: "", null: false
    t.string "name", default: "", null: false
    t.jsonb "meta_data", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discord_guild_id"], name: "index_guilds_on_discord_guild_id", unique: true
  end

  create_table "interactions", force: :cascade do |t|
    t.bigint "webhook_event_id"
    t.string "interaction_id", default: "", null: false
    t.string "service_name", default: "", null: false
    t.string "type", default: "", null: false
    t.string "timestamp", default: "", null: false
    t.jsonb "meta_data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["webhook_event_id"], name: "index_interactions_on_webhook_event_id"
  end

  create_table "registered_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "guild_id", null: false
    t.uuid "uuid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guild_id"], name: "index_registered_users_on_guild_id"
    t.index ["user_id", "guild_id"], name: "index_registered_users_on_user_id_and_guild_id", unique: true
    t.index ["user_id"], name: "index_registered_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "discord_user_id", default: "", null: false
    t.jsonb "meta_data", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discord_user_id"], name: "index_users_on_discord_user_id", unique: true
  end

  create_table "webhook_events", force: :cascade do |t|
    t.string "request_id", default: "", null: false
    t.string "request_type", default: "", null: false
    t.string "request_body", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "application_commands", "application_command_types"
  add_foreign_key "application_commands", "discord_applications"
  add_foreign_key "registered_users", "guilds"
  add_foreign_key "registered_users", "users"
end
