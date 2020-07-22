class CreatePromiseToHires < ActiveRecord::Migration[5.2]
  def change
    create_table :promise_to_hires do |t|
      t.string :birthday_cadre
      t.string :birthplace_cadre
      t.string :ns_sociale_cadre
      t.string :date_poste
      t.float :remuneration_fixe
      t.string :remuneration_fixe_date
      t.boolean :remuneration_variable
      t.string :remuneration_var_info
      t.float :price
      t.text :remuneration_avantage
      t.string :date_de_validite
      t.string :signature_entreprise
      t.string :signature_candidat
      t.belongs_to :client, index:true
      t.belongs_to :cadre, index:true

      t.timestamps
    end
  end
end
