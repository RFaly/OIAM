class AddConfirmTokenAtCadreInfos < ActiveRecord::Migration[5.2]
  def change
  	add_column :cadre_infos, :confirm_token, :string
  end
end
