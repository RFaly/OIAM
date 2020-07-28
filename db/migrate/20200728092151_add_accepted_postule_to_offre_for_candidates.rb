class AddAcceptedPostuleToOffreForCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :offre_for_candidates, :accepted_postule, :boolean, default: :false
  end
end
