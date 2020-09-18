class AddCompteRenduAtCadreInfos < ActiveRecord::Migration[5.2]
  def change
  	add_column :cadre_infos, :compte_rendu, :string
  	add_column :cadre_infos, :avis, :text
  end
end
