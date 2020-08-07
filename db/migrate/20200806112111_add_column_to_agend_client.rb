class AddColumnToAgendClient < ActiveRecord::Migration[5.2]
  def change
    add_column :agenda_clients, :repons_client, :boolean, default: :true
    add_column :agenda_clients, :repons_cadre, :boolean
  end
end
