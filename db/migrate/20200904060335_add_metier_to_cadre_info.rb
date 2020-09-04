class AddMetierToCadreInfo < ActiveRecord::Migration[5.2]
  def change
    add_reference :cadre_infos, :metier, foreign_key: true
  end
end
