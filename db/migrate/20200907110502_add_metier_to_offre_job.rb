class AddMetierToOffreJob < ActiveRecord::Migration[5.2]
  def change
    add_reference :offre_jobs, :metier, foreign_key: true
  end
end
