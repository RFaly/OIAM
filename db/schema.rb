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

ActiveRecord::Schema.define(version: 2020_09_18_125310) do

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
    t.string "first_name"
    t.string "last_name"
    t.string "metier"
    t.string "image"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "agenda_admins", force: :cascade do |t|
    t.datetime "entretien_date"
    t.bigint "cadre_info_id"
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted"
    t.index ["admin_id"], name: "index_agenda_admins_on_admin_id"
    t.index ["cadre_info_id"], name: "index_agenda_admins_on_cadre_info_id"
  end

  create_table "agenda_clients", force: :cascade do |t|
    t.string "adresse"
    t.string "recruteur"
    t.string "alternative"
    t.bigint "offre_for_candidate_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "entretien_date"
    t.boolean "repons_client", default: true
    t.boolean "repons_cadre"
    t.boolean "is_update"
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
    t.boolean "empty", default: true
    t.text "question1"
    t.text "question2"
    t.text "question3"
    t.text "question4"
    t.text "question5"
    t.bigint "cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "disponibilite"
    t.string "mobilite"
    t.boolean "is_validate", default: false
    t.boolean "deplacement"
    t.text "frequency"
    t.bigint "country_id"
    t.bigint "region_id"
    t.bigint "ville_id"
    t.bigint "metier_id"
    t.integer "score_potential"
    t.integer "score_fit"
    t.boolean "potential_test", default: false
    t.boolean "fit_test", default: false
    t.boolean "is_recrute"
    t.string "job"
    t.bigint "admin_id"
    t.string "confirm_token"
    t.string "compte_rendu"
    t.text "avis"
    t.index ["admin_id"], name: "index_cadre_infos_on_admin_id"
    t.index ["cadre_id"], name: "index_cadre_infos_on_cadre_id"
    t.index ["country_id"], name: "index_cadre_infos_on_country_id"
    t.index ["metier_id"], name: "index_cadre_infos_on_metier_id"
    t.index ["region_id"], name: "index_cadre_infos_on_region_id"
    t.index ["ville_id"], name: "index_cadre_infos_on_ville_id"
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

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "factures", force: :cascade do |t|
    t.float "prix"
    t.string "rib"
    t.boolean "is_payed", default: false
    t.bigint "promise_to_hire_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_factures_on_client_id"
    t.index ["promise_to_hire_id"], name: "index_factures_on_promise_to_hire_id"
  end

  create_table "favorite_jobs", force: :cascade do |t|
    t.bigint "offre_job_id"
    t.bigint "cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cadre_id"], name: "index_favorite_jobs_on_cadre_id"
    t.index ["offre_job_id"], name: "index_favorite_jobs_on_offre_job_id"
  end

  create_table "formations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "prix"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "metiers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "offre_for_candidates", force: :cascade do |t|
    t.string "status"
    t.boolean "is_recrute", default: false
    t.bigint "offre_job_id"
    t.bigint "cadre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted_postule"
    t.integer "etapes", default: 0
    t.text "refused_info"
    t.boolean "repons_postule"
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
    t.text "question4"
    t.text "question5"
    t.string "image"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "etapes", default: 0
    t.integer "numberEntretien"
    t.boolean "repons_cadre"
    t.bigint "metier_id"
    t.index ["client_id"], name: "index_offre_jobs_on_client_id"
    t.index ["metier_id"], name: "index_offre_jobs_on_metier_id"
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
    t.boolean "payed", default: false
    t.boolean "repons_client"
    t.boolean "repons_cadre"
    t.string "cin_pass_port"
    t.string "security_certificate"
    t.string "rib"
    t.index ["cadre_id"], name: "index_promise_to_hires_on_cadre_id"
    t.index ["offre_job_id"], name: "index_promise_to_hires_on_offre_job_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  create_table "villes", force: :cascade do |t|
    t.string "name"
    t.bigint "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_villes_on_region_id"
  end

  add_foreign_key "cadre_infos", "admins"
  add_foreign_key "cadre_infos", "countries"
  add_foreign_key "cadre_infos", "metiers"
  add_foreign_key "cadre_infos", "regions"
  add_foreign_key "cadre_infos", "villes"
  add_foreign_key "offre_jobs", "metiers"
end
