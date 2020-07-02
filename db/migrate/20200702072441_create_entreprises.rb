class CreateEntreprises < ActiveRecord::Migration[5.2]
  def change
    create_table :entreprises do |t|
      t.string :name
      t.string :adresse
      t.string :siret
      t.string :site
      t.text :description
    end
  end
end
