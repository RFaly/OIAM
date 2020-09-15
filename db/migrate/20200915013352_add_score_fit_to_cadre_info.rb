class AddScoreFitToCadreInfo < ActiveRecord::Migration[5.2]
  def change
  	remove_column :cadre_infos, :potential_test, :integer
  	remove_column :cadre_infos, :skils_test, :integer
  	remove_column :cadre_infos, :fit_test, :boolean
    add_column :cadre_infos, :score_potential, :integer
    add_column :cadre_infos, :score_fit, :integer
    add_column :cadre_infos, :potential_test, :boolean, default:false
    add_column :cadre_infos, :fit_test, :boolean, default:false
    add_column :cadre_infos, :is_recrute, :boolean
    add_column :cadre_infos, :job, :string
  end
end
