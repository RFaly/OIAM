class CreateFactures < ActiveRecord::Migration[5.2]
  def change
    create_table :factures do |t|
      t.float :prix
      t.string :rib
      t.boolean :is_payed, default: :false

      t.belongs_to :promise_to_hire
      t.belongs_to :client, index:true
      
      t.timestamps
    end
  end
end
