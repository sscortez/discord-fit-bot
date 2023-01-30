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

ActiveRecord::Schema[7.0].define(version: 2023_01_25_144836) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "users", force: :cascade do |t|
    t.string "discord_name", null: false
    t.string "discord_id", null: false
    t.string "discord_meta_data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "webhook_events", force: :cascade do |t|
    t.string "request_id", default: "", null: false
    t.string "request_type", default: "", null: false
    t.string "request_body", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
