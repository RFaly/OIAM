class AddAdminToCadreInfo < ActiveRecord::Migration[5.2]
  def change
    add_reference :cadre_infos, :admin, foreign_key: true
  end
end
