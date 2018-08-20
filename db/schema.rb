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

ActiveRecord::Schema.define(version: 2018_08_07_095327) do

  create_table "audits", force: :cascade do |t|
    t.string "auditable_type"
    t.integer "auditable_id"
    t.integer "user_id"
    t.string "action"
    t.string "record_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auditable_type", "auditable_id"], name: "index_audits_on_auditable_type_and_auditable_id"
    t.index ["user_id"], name: "index_audits_on_user_id"
  end

  create_table "consumable_types", force: :cascade do |t|
    t.string "name"
    t.integer "days_to_keep"
    t.integer "storage_condition", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "last_label_id"
    t.boolean "active", default: true, null: false
  end

  create_table "consumables", force: :cascade do |t|
    t.integer "batch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "barcode"
    t.boolean "depleted", default: false
    t.decimal "volume", precision: 10, scale: 3
    t.integer "unit"
    t.integer "sub_batch_id"
    t.index ["batch_id"], name: "index_consumables_on_batch_id"
  end

  create_table "favourites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "consumable_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consumable_type_id"], name: "index_favourites_on_consumable_type_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer "consumable_type_id"
    t.integer "kitchen_id"
    t.string "number"
    t.string "type"
    t.date "expiry_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "editable", default: true
    t.index ["consumable_type_id"], name: "index_ingredients_on_consumable_type_id"
    t.index ["kitchen_id"], name: "index_ingredients_on_kitchen_id"
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "kitchens", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.boolean "active", default: true, null: false
  end

  create_table "label_types", force: :cascade do |t|
    t.string "name"
    t.integer "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mixtures", force: :cascade do |t|
    t.integer "batch_id"
    t.integer "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "quantity"
    t.integer "unit_id"
    t.index ["batch_id"], name: "index_mixtures_on_batch_id"
    t.index ["ingredient_id"], name: "index_mixtures_on_ingredient_id"
    t.index ["unit_id"], name: "index_mixtures_on_unit_id"
  end

  create_table "printers", force: :cascade do |t|
    t.string "name"
    t.integer "label_type_id"
    t.index ["label_type_id"], name: "index_printers_on_label_type_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true, null: false
  end

  create_table "sub_batches", force: :cascade do |t|
    t.float "volume"
    t.integer "unit"
    t.integer "project_id"
    t.integer "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_sub_batches_on_ingredient_id"
    t.index ["project_id"], name: "index_sub_batches_on_project_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_units_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.integer "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_users_on_team_id"
  end

end
