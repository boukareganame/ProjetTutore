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

ActiveRecord::Schema[8.0].define(version: 2025_04_13_144050) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "administrateurs", force: :cascade do |t|
    t.bigint "personne_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personne_id"], name: "index_administrateurs_on_personne_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "tontine_id", null: false
    t.decimal "montant"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tour_id", null: false
    t.index ["participant_id"], name: "index_contributions_on_participant_id"
    t.index ["tontine_id"], name: "index_contributions_on_tontine_id"
    t.index ["tour_id"], name: "index_contributions_on_tour_id"
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "personne_id", null: false
    t.bigint "tontine_id", null: false
    t.date "date_d_adhesion"
    t.decimal "montant_contribution_initiale"
    t.string "role"
    t.string "statut"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["personne_id"], name: "index_participants_on_personne_id"
    t.index ["tontine_id"], name: "index_participants_on_tontine_id"
  end

  create_table "personnes", force: :cascade do |t|
    t.string "nom"
    t.string "prenom"
    t.string "email"
    t.string "telephone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_personnes_on_email", unique: true
    t.index ["reset_password_token"], name: "index_personnes_on_reset_password_token", unique: true
  end

  create_table "tontines", force: :cascade do |t|
    t.string "description"
    t.string "frequence"
    t.decimal "montant"
    t.string "statut"
    t.bigint "organisateur_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organisateur_id"], name: "index_tontines_on_organisateur_id"
  end

  create_table "tours", force: :cascade do |t|
    t.integer "ordre"
    t.bigint "tontine_id", null: false
    t.bigint "beneficiaire_id"
    t.date "date_tirage"
    t.boolean "beneficiaire_aleatoire"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beneficiaire_id"], name: "index_tours_on_beneficiaire_id"
    t.index ["tontine_id"], name: "index_tours_on_tontine_id"
  end

  add_foreign_key "administrateurs", "personnes"
  add_foreign_key "contributions", "participants"
  add_foreign_key "contributions", "tontines"
  add_foreign_key "contributions", "tours"
  add_foreign_key "participants", "personnes"
  add_foreign_key "participants", "tontines"
  add_foreign_key "tontines", "personnes", column: "organisateur_id"
  add_foreign_key "tours", "personnes", column: "beneficiaire_id"
  add_foreign_key "tours", "tontines"
end
