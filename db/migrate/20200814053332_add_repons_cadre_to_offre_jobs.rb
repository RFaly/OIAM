class AddReponsCadreToOffreJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :offre_jobs, :repons_cadre, :boolean
  end
end
