class AddIsValidateToCadreInfos < ActiveRecord::Migration[5.2]
  def change
    add_column :cadre_infos, :is_validate, :boolean, default: :false
  end
end
