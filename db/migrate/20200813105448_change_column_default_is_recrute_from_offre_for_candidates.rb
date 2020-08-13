class ChangeColumnDefaultIsRecruteFromOffreForCandidates < ActiveRecord::Migration[5.2]
  def change
  	change_column_default(:offre_for_candidates, :is_recrute, nil)
  end
end
