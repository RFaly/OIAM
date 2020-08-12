class AddColumnToOffreJob < ActiveRecord::Migration[5.2]
  def change
    add_column :offre_jobs, :etapes, :integer, default:0
    add_column :offre_jobs, :numberEntretien, :integer
  end
end
