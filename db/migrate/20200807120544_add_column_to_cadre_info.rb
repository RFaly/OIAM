class AddColumnToCadreInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :cadre_infos, :disponibilite, :string
  end
end
