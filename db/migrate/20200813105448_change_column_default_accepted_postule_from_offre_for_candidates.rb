class ChangeColumnDefaultAcceptedPostuleFromOffreForCandidates < ActiveRecord::Migration[5.2]
  def change
  	change_column_default(:offre_for_candidates, :accepted_postule, nil)
  end
end
