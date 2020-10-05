class CreateFactureFormations < ActiveRecord::Migration[5.2]
  def change
    create_table :facture_formations do |t|
      t.string :ov
      t.float :prix
      t.boolean :is_payed

      t.belongs_to :formation, index:true
      t.belongs_to :cadre, index:true

      t.timestamps
    end
  end
end
