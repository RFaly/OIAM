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

ActiveRecord::Schema.define(version: 2020_07_28_092151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "agenda_clients", force: :cascade do |t|
    t.string "entretien_date"
    t.string "entretien_time"
    t.string "adresse"
    t.string "recruteur"
    t.string "alternative"
    t.boolean "is_accepted", default: false
    t.bigint "offre_for_candidate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offre_for_candidate_id"], name: "index_agenda_clients_on_offre_for_candidate_id"
  end

  create_table "cadre_infos", force: :cascade do |t|
    t.string "image"
    t.string "cv"
    t.string "first_name"
    t.string "last_name"
    t.string "adresse"
    t.string "postal_code"
    t.string "city"
    t.string "mail"
    t.string "status"
    t.string "situation"
    t.string "telephone"
    t.integer "potential_test"
    t.integer "skils_test"
    t.boolean "fit_test"
    t.boolean "empty", default: true
    t.text "avis_recruteur"
    t.text "question1"
    t.text "question2"
    t.text "question3"
    t.text "question4"
    t.text "question5"
    t.bigint "cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cadre_id"], name: "index_cadre_infos_on_cadre_id"
  end

  create_table "cadres", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "online_time"
    t.index ["email"], name: "index_cadres_on_email", unique: true
    t.index ["reset_password_token"], name: "index_cadres_on_reset_password_token", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "fonction"
    t.string "mail"
    t.string "telephone"
    t.string "image"
    t.datetime "online_time"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "contact_admin_cadres", force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_contact_admin_cadres_on_admin_id"
    t.index ["cadre_id"], name: "index_contact_admin_cadres_on_cadre_id"
  end

  create_table "contact_admin_clients", force: :cascade do |t|
    t.bigint "admin_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_contact_admin_clients_on_admin_id"
    t.index ["client_id"], name: "index_contact_admin_clients_on_client_id"
  end

  create_table "contact_client_cadres", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cadre_id"], name: "index_contact_client_cadres_on_cadre_id"
    t.index ["client_id"], name: "index_contact_client_cadres_on_client_id"
  end

  create_table "entreprises", force: :cascade do |t|
    t.string "name"
    t.string "adresse"
    t.string "siret"
    t.string "city"
    t.string "postal_code"
    t.string "code_naf"
    t.string "site"
    t.text "description"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_entreprises_on_client_id"
  end

  create_table "favotire_jobs", force: :cascade do |t|
    t.bigint "offre_job_id"
    t.bigint "cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cadre_id"], name: "index_favotire_jobs_on_cadre_id"
    t.index ["offre_job_id"], name: "index_favotire_jobs_on_offre_job_id"
  end

  create_table "message_admin_cadres", force: :cascade do |t|
    t.text "content"
    t.boolean "cadre_see", default: false
    t.boolean "admin_see", default: false
    t.boolean "is_admin", default: true
    t.bigint "contact_admin_cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_admin_cadre_id"], name: "index_message_admin_cadres_on_contact_admin_cadre_id"
  end

  create_table "message_admin_clients", force: :cascade do |t|
    t.text "content"
    t.boolean "client_see", default: false
    t.boolean "admin_see", default: false
    t.boolean "is_admin", default: true
    t.bigint "contact_admin_client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_admin_client_id"], name: "index_message_admin_clients_on_contact_admin_client_id"
  end

  create_table "message_client_cadres", force: :cascade do |t|
    t.text "content"
    t.boolean "client_see", default: false
    t.boolean "cadre_see", default: false
    t.boolean "is_client", default: false
    t.bigint "contact_client_cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_client_cadre_id"], name: "index_message_client_cadres_on_contact_client_cadre_id"
  end

  create_table "offre_for_candidates", force: :cascade do |t|
    t.string "status"
    t.boolean "is_recrute", default: false
    t.bigint "offre_job_id"
    t.bigint "cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted_postule", default: false
    t.index ["cadre_id"], name: "index_offre_for_candidates_on_cadre_id"
    t.index ["offre_job_id"], name: "index_offre_for_candidates_on_offre_job_id"
  end

  create_table "offre_jobs", force: :cascade do |t|
    t.string "country"
    t.string "region"
    t.string "department"
    t.string "intitule_pote"
    t.text "descriptif_mission"
    t.string "rattachement"
    t.float "remuneration"
    t.float "remuneration_anne"
    t.boolean "contrat_cdi", default: false
    t.boolean "is_publish", default: false
    t.string "type_deplacement"
    t.string "date_poste"
    t.text "question1"
    t.text "question2"
    t.text "question3"
    t.text "question4"
    t.text "question5"
    t.string "image"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_offre_jobs_on_client_id"
  end

  create_table "promise_to_hires", force: :cascade do |t|
    t.string "birthday_cadre"
    t.string "birthplace_cadre"
    t.string "ns_sociale_cadre"
    t.string "date_poste"
    t.float "remuneration_fixe"
    t.string "remuneration_fixe_date"
    t.boolean "remuneration_variable"
    t.string "remuneration_var_info"
    t.float "price"
    t.text "remuneration_avantage"
    t.string "date_de_validite"
    t.string "signature_entreprise"
    t.string "signature_candidat"
    t.bigint "offre_job_id"
    t.bigint "cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cadre_id"], name: "index_promise_to_hires_on_cadre_id"
    t.index ["offre_job_id"], name: "index_promise_to_hires_on_offre_job_id"
  end

end
