class CreateOffreJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :offre_jobs do |t|
      t.string :country
      t.string :region
      t.string :department
      t.string :intitule_pote
      t.text :descriptif_mission
      t.string :rattachement #_hierarchique
      t.float :remuneration
      t.float :remuneration_anne
      t.boolean :contrat_cdi, default: :false
      t.string :type_deplacement
      t.string :date_poste #_prise_de
      t.text :question1
      t.text :question2
      t.text :question3
      t.text :question4
      t.text :question5
      t.string :image
      t.belongs_to :client, index:true

      t.timestamps
    end
  end
end
