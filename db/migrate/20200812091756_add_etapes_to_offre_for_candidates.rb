class AddEtapesToOffreForCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :offre_for_candidates, :etapes, :integer, default:0
  end
end
