class AddQuestion4ToCadreInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :cadre_infos, :question4, :float
  end
end
