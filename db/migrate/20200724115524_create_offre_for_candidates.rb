class CreateOffreForCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :offre_for_candidates do |t|
      t.string :status
      t.boolean :is_recrute
      t.belongs_to :offre_job, index:true
      t.belongs_to :cadre, index:true

      t.timestamps
    end
  end
end
