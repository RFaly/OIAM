class RemoveQuestion3FromOffreJobs < ActiveRecord::Migration[5.2]
  def change
    remove_column :offre_jobs, :question3, :text
  end
end
