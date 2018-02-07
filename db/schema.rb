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

ActiveRecord::Schema.define(version: 20180207152817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_players", force: :cascade do |t|
    t.integer "position"
    t.bigint "player_id"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_players_on_game_id"
    t.index ["player_id"], name: "index_game_players_on_player_id"
  end

  create_table "games", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "size", default: 4, null: false
  end

  create_table "hand_players", force: :cascade do |t|
    t.integer "position"
    t.integer "bid"
    t.integer "tricks"
    t.bigint "hand_id"
    t.bigint "game_player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_player_id"], name: "index_hand_players_on_game_player_id"
    t.index ["hand_id"], name: "index_hand_players_on_hand_id"
  end

  create_table "hands", force: :cascade do |t|
    t.integer "position"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dealer_id"
    t.index ["game_id"], name: "index_hands_on_game_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "game_players", "games"
  add_foreign_key "game_players", "players"
  add_foreign_key "hand_players", "game_players"
  add_foreign_key "hand_players", "hands"
  add_foreign_key "hands", "games"
end
