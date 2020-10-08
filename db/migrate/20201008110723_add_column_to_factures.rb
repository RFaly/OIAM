class AddColumnToFactures < ActiveRecord::Migration[5.2]
  def change
    add_column :factures, :confirmed, :boolean
    add_column :factures, :ov, :string
  end
end
