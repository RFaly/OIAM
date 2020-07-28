class AddIdSercureToOffreJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :offre_jobs, :id_secure, :string
  end
end
