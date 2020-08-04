class RemoveEntretienTimeFromAgendaClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :agenda_clients, :entretien_time, :string
    remove_column :agenda_clients, :entretien_date, :string
  end
end
