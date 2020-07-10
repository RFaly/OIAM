class CreateEntreprises < ActiveRecord::Migration[5.2]
  def change
    create_table :entreprises do |t|
      t.string :name
      t.string :adresse
      t.string :siret
      t.string :city
      t.string :postal_code
      t.string :code_naf
      t.string :site
      t.text :description
      t.belongs_to :client

      t.timestamps
    end
  end
end
