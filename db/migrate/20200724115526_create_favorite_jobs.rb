class CreateFavoriteJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_jobs do |t|
			t.belongs_to :offre_job, index:true
      t.belongs_to :cadre, index:true

      t.timestamps
    end
  end
end
