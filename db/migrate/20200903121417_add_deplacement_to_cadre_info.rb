class AddDeplacementToCadreInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :cadre_infos, :deplacement, :boolean
    add_column :cadre_infos, :frequency, :text
  end
end
