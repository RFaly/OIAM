class RemoveQuestion1FromCadreInfo < ActiveRecord::Migration[5.2]
  def change
    remove_column :cadre_infos, :question1, :text
  end
end
