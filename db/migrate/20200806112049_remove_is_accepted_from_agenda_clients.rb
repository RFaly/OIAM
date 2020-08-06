class RemoveIsAcceptedFromAgendaClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :agenda_clients, :is_accepted, :boolean
  end
end
