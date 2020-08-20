class AddRefusedInfoToOffreForCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :offre_for_candidates, :refused_info, :text
  end
end
