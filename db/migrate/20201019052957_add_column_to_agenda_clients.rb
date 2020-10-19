class AddColumnToAgendaClients < ActiveRecord::Migration[5.2]
  def change
    add_column :agenda_clients, :notifed, :boolean, default: :false
  end
end
