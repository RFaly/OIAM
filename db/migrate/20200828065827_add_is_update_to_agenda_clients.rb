class AddIsUpdateToAgendaClients < ActiveRecord::Migration[5.2]
  def change
    add_column :agenda_clients, :is_update, :boolean
    add_column :agenda_clients, :message, :text
  end
end
