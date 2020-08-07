class AddColumnToCadreInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :cadre_infos, :disponibilite, :string
    add_column :cadre_infos, :mobilite, :string
  end
end
