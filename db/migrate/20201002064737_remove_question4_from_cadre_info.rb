class RemoveQuestion4FromCadreInfo < ActiveRecord::Migration[5.2]
  def change
    remove_column :cadre_infos, :question4, :string
  end
end
