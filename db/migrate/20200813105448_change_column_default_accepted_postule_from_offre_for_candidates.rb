class ChangeColumnDefaultAcceptedPostuleFromOffreForCandidates < ActiveRecord::Migration[5.2]
  def up
  	change_column_default(:offre_for_candidates, :accepted_postule, nil)
	end

	def down
	  change_column_default(:offre_for_candidates, :accepted_postule, false)
	end
end
