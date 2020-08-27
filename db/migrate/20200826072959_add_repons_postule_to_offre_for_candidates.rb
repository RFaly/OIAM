class AddReponsPostuleToOffreForCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :offre_for_candidates, :repons_postule, :boolean
  end
end
