class AddCountryToCadreInfo < ActiveRecord::Migration[5.2]
  def change
    add_reference :cadre_infos, :country, foreign_key: true
    add_reference :cadre_infos, :region, foreign_key: true
    add_reference :cadre_infos, :ville, foreign_key: true
  end
end
